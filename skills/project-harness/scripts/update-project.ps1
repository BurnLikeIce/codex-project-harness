param(
    [string]$ProjectPath = (Get-Location).Path,
    [ValidateSet('en', 'zh-CN')]
    [string]$Language = 'en'
)

$ErrorActionPreference = "Stop"
$project = (Resolve-Path -LiteralPath $ProjectPath).Path
$skillRoot = Split-Path -Parent $PSScriptRoot
$managedRoot = Join-Path $skillRoot "assets\managed\$Language"

function Find-MappedExisting {
    param([string]$Pattern)

    $harnessPath = Join-Path $project 'HARNESS.md'
    if (-not (Test-Path -LiteralPath $harnessPath -PathType Leaf)) { return $null }

    $text = [IO.File]::ReadAllText($harnessPath)
    $managed = [regex]::Match(
        $text,
        '<!-- project-harness:managed:start -->(.*?)<!-- project-harness:managed:end -->',
        [Text.RegularExpressions.RegexOptions]::Singleline
    )
    if (-not $managed.Success) { return $null }

    $match = [regex]::Match($managed.Groups[1].Value, $Pattern, [Text.RegularExpressions.RegexOptions]::Multiline)
    if (-not $match.Success) { return $null }

    $mapped = $match.Groups[1].Value.Trim().Trim([char[]]'`')
    if ($mapped -eq '(not mapped)') { return $null }
    $mappedPath = if ([IO.Path]::IsPathRooted($mapped)) { $mapped } else { Join-Path $project $mapped }
    if (Test-Path -LiteralPath $mappedPath -PathType Leaf) {
        return $mapped.Replace('\', '/')
    }
    return $null
}

function Find-FirstExisting {
    param(
        [string[]]$Candidates,
        [string]$MappingPattern
    )

    $mapped = Find-MappedExisting -Pattern $MappingPattern
    if ($mapped) { return $mapped }

    foreach ($candidate in $Candidates) {
        if (Test-Path -LiteralPath (Join-Path $project $candidate) -PathType Leaf) {
            return $candidate.Replace('\', '/')
        }
    }
    return '(not mapped)'
}

function Set-ManagedBlock {
    param(
        [string]$Path,
        [string]$Heading,
        [string]$Start,
        [string]$End,
        [string]$Block
    )

    $current = if (Test-Path -LiteralPath $Path) { [IO.File]::ReadAllText($Path) } else { "$Heading`n" }
    $newline = if ($current.Contains("`r`n")) { "`r`n" } else { "`n" }
    $normalizedBlock = $Block -replace "`r?`n", $newline
    $pattern = [regex]::Escape($Start) + '.*?' + [regex]::Escape($End)

    if ([regex]::IsMatch($current, $pattern, [Text.RegularExpressions.RegexOptions]::Singleline)) {
        $updated = [regex]::Replace($current, $pattern, $normalizedBlock, [Text.RegularExpressions.RegexOptions]::Singleline)
    } else {
        $updated = $current.TrimEnd() + $newline + $newline + $normalizedBlock + $newline
    }

    if ($updated -cne $current) {
        [IO.File]::WriteAllText($Path, $updated, [Text.UTF8Encoding]::new($false))
        Write-Output "UPDATE: $([IO.Path]::GetFileName($Path))"
    } else {
        Write-Output "UNCHANGED: $([IO.Path]::GetFileName($Path))"
    }
}

$sources = [ordered]@{
    Tasks        = Find-FirstExisting -Candidates @('docs/tasks.md', 'TASKS.md', 'docs/task.md') -MappingPattern '^\s*-\s*(?:Tasks|任务记录)\s*[:：]\s*(.+?)\s*$'
    Decisions    = Find-FirstExisting -Candidates @('docs/decisions.md', 'DECISIONS.md', 'docs/decision-log.md') -MappingPattern '^\s*-\s*(?:Decisions|决策记录)\s*[:：]\s*(.+?)\s*$'
    Product      = Find-FirstExisting -Candidates @('docs/product.md', 'docs/prd.md', 'PRD.md', 'docs/product-spec.md') -MappingPattern '^\s*-\s*(?:Product|产品事实)\s*[:：]\s*(.+?)\s*$'
    Architecture = Find-FirstExisting -Candidates @('docs/architecture.md', 'ARCHITECTURE.md', 'docs/design.md') -MappingPattern '^\s*-\s*(?:Architecture|架构事实)\s*[:：]\s*(.+?)\s*$'
    API          = Find-FirstExisting -Candidates @('docs/api-contract.md', 'docs/api.md', 'API.md', 'openapi.yaml', 'openapi.yml') -MappingPattern '^\s*-\s*(?:API|API 契约)\s*[:：]\s*(.+?)\s*$'
    Acceptance   = Find-FirstExisting -Candidates @('docs/acceptance.md', 'docs/testing.md', 'TESTING.md') -MappingPattern '^\s*-\s*(?:Acceptance|验收依据)\s*[:：]\s*(.+?)\s*$'
    Handoff      = Find-FirstExisting -Candidates @('docs/handovers/current-control-state.md', 'docs/handoff.md', 'HANDOFF.md') -MappingPattern '^\s*-\s*(?:Handoff|主控交接)\s*[:：]\s*(.+?)\s*$'
}

$harnessHeading = '# Project Harness'
$agentsHeading = '# Agent Instructions'
$harnessBlock = [IO.File]::ReadAllText((Join-Path $managedRoot 'harness-block.md')).TrimEnd()
$agentsBlock = [IO.File]::ReadAllText((Join-Path $managedRoot 'agents-block.md')).TrimEnd()

$replacements = [ordered]@{
    '{{TASKS}}'        = $sources.Tasks
    '{{DECISIONS}}'    = $sources.Decisions
    '{{PRODUCT}}'      = $sources.Product
    '{{ARCHITECTURE}}' = $sources.Architecture
    '{{API}}'          = $sources.API
    '{{ACCEPTANCE}}'   = $sources.Acceptance
    '{{HANDOFF}}'      = $sources.Handoff
}
foreach ($token in $replacements.Keys) {
    $harnessBlock = $harnessBlock.Replace($token, $replacements[$token])
}

Set-ManagedBlock -Path (Join-Path $project 'HARNESS.md') -Heading $harnessHeading -Start '<!-- project-harness:managed:start -->' -End '<!-- project-harness:managed:end -->' -Block $harnessBlock
Set-ManagedBlock -Path (Join-Path $project 'AGENTS.md') -Heading $agentsHeading -Start '<!-- project-harness:entry:start -->' -End '<!-- project-harness:entry:end -->' -Block $agentsBlock

Write-Output "Project Harness protocol updated in place at: $project"
Write-Output "No existing project documents were moved, deleted, or rewritten outside managed blocks."
