param(
    [string]$ProjectPath = (Get-Location).Path
)

$ErrorActionPreference = "Stop"
$project = (Resolve-Path -LiteralPath $ProjectPath).Path
$errors = [Collections.Generic.List[string]]::new()

function Check-ManagedFile {
    param(
        [string]$RelativePath,
        [string]$Start,
        [string]$End
    )

    $path = Join-Path $project $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors.Add("Missing $RelativePath")
        return
    }

    $text = [IO.File]::ReadAllText($path)
    if ([regex]::Matches($text, [regex]::Escape($Start)).Count -ne 1) { $errors.Add("$RelativePath must contain exactly one managed start marker") }
    if ([regex]::Matches($text, [regex]::Escape($End)).Count -ne 1) { $errors.Add("$RelativePath must contain exactly one managed end marker") }
    if ($text -match '(?m)^(<<<<<<<|=======|>>>>>>>)') { $errors.Add("$RelativePath contains merge conflict markers") }
}

Check-ManagedFile -RelativePath 'HARNESS.md' -Start '<!-- project-harness:managed:start -->' -End '<!-- project-harness:managed:end -->'
Check-ManagedFile -RelativePath 'AGENTS.md' -Start '<!-- project-harness:entry:start -->' -End '<!-- project-harness:entry:end -->'

foreach ($relative in @('docs/tasks.md', 'docs/decisions.md')) {
    $path = Join-Path $project $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Write-Warning "$relative is not present; this is valid only when HARNESS.md maps an equivalent existing source."
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "VALID: Project Harness managed structure at $project"
