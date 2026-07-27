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

function Check-MappedSource {
    param(
        [string]$Label,
        [string]$Pattern
    )

    $harnessPath = Join-Path $project 'HARNESS.md'
    if (-not (Test-Path -LiteralPath $harnessPath -PathType Leaf)) { return }

    $text = [IO.File]::ReadAllText($harnessPath)
    $managedMatch = [regex]::Match(
        $text,
        '<!-- project-harness:managed:start -->(.*?)<!-- project-harness:managed:end -->',
        [Text.RegularExpressions.RegexOptions]::Singleline
    )
    if (-not $managedMatch.Success) { return }

    $match = [regex]::Match($managedMatch.Groups[1].Value, $Pattern, [Text.RegularExpressions.RegexOptions]::Multiline)
    if (-not $match.Success) {
        $errors.Add("HARNESS.md does not map $Label")
        return
    }

    $relative = $match.Groups[1].Value.Trim().Trim([char[]]'`')
    if ($relative -eq '(not mapped)') {
        $errors.Add("HARNESS.md leaves $Label as (not mapped)")
        return
    }

    $path = if ([IO.Path]::IsPathRooted($relative)) { $relative } else { Join-Path $project $relative }
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors.Add("HARNESS.md maps $Label to missing file: $relative")
    }
}

Check-MappedSource -Label 'tasks' -Pattern '^\s*-\s*(?:Tasks|任务记录)\s*[:：]\s*(.+?)\s*$'
Check-MappedSource -Label 'decisions' -Pattern '^\s*-\s*(?:Decisions|决策记录)\s*[:：]\s*(.+?)\s*$'

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "VALID: Project Harness managed structure at $project"
