param(
    [string]$ProjectPath = (Get-Location).Path
)

$ErrorActionPreference = "Stop"
$resolvedProject = (Resolve-Path -LiteralPath $ProjectPath).Path

Write-Output "Project: $resolvedProject"
Write-Output ""

$gitDir = Join-Path $resolvedProject ".git"
if (Test-Path -LiteralPath $gitDir) {
    Write-Output "Git: present"
    Push-Location $resolvedProject
    try {
        $branch = git branch --show-current
        $status = git status --short
        $remote = git remote -v
        Write-Output "Branch: $branch"
        if ($remote) {
            Write-Output "Remote:"
            $remote | ForEach-Object { Write-Output "  $_" }
        } else {
            Write-Output "Remote: none"
        }
        if ($status) {
            Write-Output "Working tree:"
            $status | ForEach-Object { Write-Output "  $_" }
        } else {
            Write-Output "Working tree: clean"
        }
    } finally {
        Pop-Location
    }
} else {
    Write-Output "Git: missing"
}

Write-Output ""
Write-Output "Harness files:"

$required = @(
    "HARNESS.md",
    "docs\sop.md",
    "docs\product.md",
    "docs\architecture.md",
    "docs\api-contract.md",
    "docs\tasks.md",
    "docs\acceptance.md",
    "docs\decisions.md",
    "docs\changelog.md",
    "prompts\master.md",
    "prompts\product.md",
    "prompts\frontend.md",
    "prompts\backend.md",
    ".github\pull_request_template.md"
)

foreach ($item in $required) {
    $path = Join-Path $resolvedProject $item
    if (Test-Path -LiteralPath $path) {
        Write-Output "OK   $item"
    } else {
        Write-Output "MISS $item"
    }
}
