param(
    [string]$ProjectPath = (Get-Location).Path,
    [ValidateSet('en', 'zh-CN')]
    [string]$Language = 'en'
)

$ErrorActionPreference = "Stop"
$project = (Resolve-Path -LiteralPath $ProjectPath).Path
$skillRoot = Split-Path -Parent $PSScriptRoot
$templateRoot = Join-Path $skillRoot "assets\minimal-project\$Language"
$managedRoot = Join-Path $skillRoot "assets\managed\$Language"

if (-not (Test-Path -LiteralPath $templateRoot -PathType Container)) {
    throw "Template root not found: $templateRoot"
}

function Find-FirstExisting {
    param([string[]]$Candidates)

    foreach ($candidate in $Candidates) {
        if (Test-Path -LiteralPath (Join-Path $project $candidate) -PathType Leaf) {
            return $candidate
        }
    }
    return $null
}

function Copy-MissingFile {
    param([string]$RelativePath)

    $source = Join-Path $templateRoot $RelativePath
    $destination = Join-Path $project $RelativePath
    if (Test-Path -LiteralPath $destination) {
        Write-Output "SKIP existing: $RelativePath"
        return
    }

    $parent = Split-Path -Parent $destination
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent | Out-Null
    }
    Copy-Item -LiteralPath $source -Destination $destination
    Write-Output "CREATE: $RelativePath"
}

function Set-ManagedBlock {
    param(
        [string]$Path,
        [string]$Heading,
        [string]$Block
    )

    $start = '<!-- project-harness:entry:start -->'
    $end = '<!-- project-harness:entry:end -->'
    $current = if (Test-Path -LiteralPath $Path) { [IO.File]::ReadAllText($Path) } else { "$Heading`n" }
    $newline = if ($current.Contains("`r`n")) { "`r`n" } else { "`n" }
    $normalizedBlock = $Block -replace "`r?`n", $newline
    $pattern = [regex]::Escape($start) + '.*?' + [regex]::Escape($end)

    if ([regex]::IsMatch($current, $pattern, [Text.RegularExpressions.RegexOptions]::Singleline)) {
        $updated = [regex]::Replace($current, $pattern, $normalizedBlock, [Text.RegularExpressions.RegexOptions]::Singleline)
    } else {
        $updated = $current.TrimEnd() + $newline + $newline + $normalizedBlock + $newline
    }

    if ($updated -cne $current) {
        [IO.File]::WriteAllText($Path, $updated, [Text.UTF8Encoding]::new($false))
        Write-Output "UPDATE: AGENTS.md"
    } else {
        Write-Output "UNCHANGED: AGENTS.md"
    }
}

Copy-MissingFile 'HARNESS.md'
if (-not (Find-FirstExisting @('docs/tasks.md', 'TASKS.md', 'docs/task.md'))) {
    Copy-MissingFile 'docs/tasks.md'
} else {
    Write-Output 'REUSE existing task source'
}
if (-not (Find-FirstExisting @('docs/decisions.md', 'DECISIONS.md', 'docs/decision-log.md'))) {
    Copy-MissingFile 'docs/decisions.md'
} else {
    Write-Output 'REUSE existing decision source'
}

$heading = '# Agent Instructions'
$block = [IO.File]::ReadAllText((Join-Path $managedRoot 'agents-block.md')).TrimEnd()

Set-ManagedBlock -Path (Join-Path $project 'AGENTS.md') -Heading $heading -Block $block
& (Join-Path $PSScriptRoot 'update-project.ps1') -ProjectPath $project -Language $Language
& (Join-Path $PSScriptRoot 'validate-project.ps1') -ProjectPath $project
Write-Output "Project Harness 2 initialized or adopted at: $project"
