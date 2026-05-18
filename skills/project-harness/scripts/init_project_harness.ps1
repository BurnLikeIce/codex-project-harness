param(
    [string]$ProjectPath = (Get-Location).Path,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$skillRoot = Split-Path -Parent $PSScriptRoot
$templateRoot = Join-Path $skillRoot "assets\project-template"

if (-not (Test-Path -LiteralPath $templateRoot)) {
    throw "Template root not found: $templateRoot"
}

$resolvedProject = (Resolve-Path -LiteralPath $ProjectPath).Path

function Copy-TemplateFile {
    param(
        [string]$Source,
        [string]$Destination
    )

    $destinationDir = Split-Path -Parent $Destination
    if (-not (Test-Path -LiteralPath $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir | Out-Null
    }

    if ((Test-Path -LiteralPath $Destination) -and -not $Force) {
        Write-Output "SKIP existing: $Destination"
        return
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Force
    Write-Output "COPY: $Destination"
}

Get-ChildItem -LiteralPath $templateRoot -Recurse -File | ForEach-Object {
    $relative = $_.FullName.Substring($templateRoot.Length).TrimStart('\', '/')
    $destination = Join-Path $resolvedProject $relative
    Copy-TemplateFile -Source $_.FullName -Destination $destination
}

Write-Output ""
Write-Output "Project harness installed at: $resolvedProject"
Write-Output "Next: use prompts/master.md in this conversation. Default to single-conversation harness mode; create specialist conversations only when useful."
