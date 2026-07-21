param(
    [string]$ProjectPath = (Get-Location).Path,
    [ValidateSet('en', 'zh-CN')]
    [string]$Language = 'en'
)

$ErrorActionPreference = "Stop"
$project = (Resolve-Path -LiteralPath $ProjectPath).Path
$skillRoot = Split-Path -Parent $PSScriptRoot
$managedRoot = Join-Path $skillRoot "assets\managed\$Language"

function Find-FirstExisting {
    param([string[]]$Candidates)

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
    Tasks        = Find-FirstExisting @('docs/tasks.md', 'TASKS.md', 'docs/task.md')
    Decisions    = Find-FirstExisting @('docs/decisions.md', 'DECISIONS.md', 'docs/decision-log.md')
    Product      = Find-FirstExisting @('docs/product.md', 'docs/prd.md', 'PRD.md', 'docs/product-spec.md')
    Architecture = Find-FirstExisting @('docs/architecture.md', 'ARCHITECTURE.md', 'docs/design.md')
    API          = Find-FirstExisting @('docs/api-contract.md', 'docs/api.md', 'API.md', 'openapi.yaml', 'openapi.yml')
    Acceptance   = Find-FirstExisting @('docs/acceptance.md', 'docs/testing.md', 'TESTING.md')
    Handoff      = Find-FirstExisting @('docs/handovers/current-control-state.md', 'docs/handoff.md', 'HANDOFF.md')
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
