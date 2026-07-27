param(
    [string]$ProjectPath = (Get-Location).Path
)

$ErrorActionPreference = "Stop"
$project = (Resolve-Path -LiteralPath $ProjectPath).Path

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
    return $null
}

$sources = [ordered]@{
    tasks        = Find-FirstExisting -Candidates @('docs/tasks.md', 'TASKS.md', 'docs/task.md') -MappingPattern '^\s*-\s*(?:Tasks|任务记录)\s*[:：]\s*(.+?)\s*$'
    decisions    = Find-FirstExisting -Candidates @('docs/decisions.md', 'DECISIONS.md', 'docs/decision-log.md') -MappingPattern '^\s*-\s*(?:Decisions|决策记录)\s*[:：]\s*(.+?)\s*$'
    product      = Find-FirstExisting -Candidates @('docs/product.md', 'docs/prd.md', 'PRD.md', 'docs/product-spec.md') -MappingPattern '^\s*-\s*(?:Product|产品事实)\s*[:：]\s*(.+?)\s*$'
    architecture = Find-FirstExisting -Candidates @('docs/architecture.md', 'ARCHITECTURE.md', 'docs/design.md') -MappingPattern '^\s*-\s*(?:Architecture|架构事实)\s*[:：]\s*(.+?)\s*$'
    api          = Find-FirstExisting -Candidates @('docs/api-contract.md', 'docs/api.md', 'API.md', 'openapi.yaml', 'openapi.yml') -MappingPattern '^\s*-\s*(?:API|API 契约)\s*[:：]\s*(.+?)\s*$'
    acceptance   = Find-FirstExisting -Candidates @('docs/acceptance.md', 'docs/testing.md', 'TESTING.md') -MappingPattern '^\s*-\s*(?:Acceptance|验收依据)\s*[:：]\s*(.+?)\s*$'
    handoff      = Find-FirstExisting -Candidates @('docs/handovers/current-control-state.md', 'docs/handoff.md', 'HANDOFF.md') -MappingPattern '^\s*-\s*(?:Handoff|主控交接)\s*[:：]\s*(.+?)\s*$'
}

$legacyNames = @(
    'docs/sop.md', 'docs/intent.md', 'docs/migration.md', 'docs/refresh.md',
    'docs/dispatch.md', 'docs/triage.md', 'docs/completion.md',
    'docs/single-conversation-harness.md', 'docs/worktrees.md', 'prompts/master.md'
)
$legacyFiles = @($legacyNames | Where-Object { Test-Path -LiteralPath (Join-Path $project $_) -PathType Leaf })

$protocol = 'unversioned'
$harnessPath = Join-Path $project 'HARNESS.md'
if (Test-Path -LiteralPath $harnessPath -PathType Leaf) {
    $harnessText = [IO.File]::ReadAllText($harnessPath)
    if ($harnessText.Contains('<!-- project-harness:managed:start -->')) {
        $protocol = '2'
    } elseif ($legacyFiles.Count -gt 0) {
        $protocol = '1-compatible'
    }
} elseif ($legacyFiles.Count -gt 0) {
    $protocol = '1-compatible'
}

$git = [ordered]@{
    repository = $false
    branch     = $null
    dirty      = $null
    remote     = $null
}

if (Get-Command git -ErrorAction SilentlyContinue) {
    $inside = (& git -C $project rev-parse --is-inside-work-tree 2>$null)
    if ($LASTEXITCODE -eq 0 -and $inside -eq 'true') {
        $git.repository = $true
        $git.branch = (& git -C $project branch --show-current 2>$null)
        $git.dirty = [bool](& git -C $project status --porcelain 2>$null)
        $git.remote = (& git -C $project remote get-url origin 2>$null)
        if ($LASTEXITCODE -ne 0) { $git.remote = $null }
    }
}

[ordered]@{
    projectPath = $project
    protocol    = $protocol
    harnessFile = if (Test-Path -LiteralPath $harnessPath -PathType Leaf) { 'HARNESS.md' } else { $null }
    agentsFile  = if (Test-Path -LiteralPath (Join-Path $project 'AGENTS.md') -PathType Leaf) { 'AGENTS.md' } else { $null }
    sources     = $sources
    legacyFiles = $legacyFiles
    git         = $git
} | ConvertTo-Json -Depth 5
