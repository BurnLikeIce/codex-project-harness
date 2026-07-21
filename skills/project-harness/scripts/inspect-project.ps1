param(
    [string]$ProjectPath = (Get-Location).Path
)

$ErrorActionPreference = "Stop"
$project = (Resolve-Path -LiteralPath $ProjectPath).Path

function Find-FirstExisting {
    param([string[]]$Candidates)

    foreach ($candidate in $Candidates) {
        if (Test-Path -LiteralPath (Join-Path $project $candidate) -PathType Leaf) {
            return $candidate.Replace('\', '/')
        }
    }
    return $null
}

$sources = [ordered]@{
    tasks        = Find-FirstExisting @('docs/tasks.md', 'TASKS.md', 'docs/task.md')
    decisions    = Find-FirstExisting @('docs/decisions.md', 'DECISIONS.md', 'docs/decision-log.md')
    product      = Find-FirstExisting @('docs/product.md', 'docs/prd.md', 'PRD.md', 'docs/product-spec.md')
    architecture = Find-FirstExisting @('docs/architecture.md', 'ARCHITECTURE.md', 'docs/design.md')
    api          = Find-FirstExisting @('docs/api-contract.md', 'docs/api.md', 'API.md', 'openapi.yaml', 'openapi.yml')
    acceptance   = Find-FirstExisting @('docs/acceptance.md', 'docs/testing.md', 'TESTING.md')
    handoff      = Find-FirstExisting @('docs/handovers/current-control-state.md', 'docs/handoff.md', 'HANDOFF.md')
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
