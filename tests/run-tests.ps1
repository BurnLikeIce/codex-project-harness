$ErrorActionPreference = "Stop"

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$skill = Join-Path $repo 'skills\project-harness'
$temp = Join-Path $PSScriptRoot '.tmp-tests-ps'

function Remove-SafeTemp {
    if (-not (Test-Path -LiteralPath $temp)) { return }
    $resolved = (Resolve-Path -LiteralPath $temp).Path
    if (-not $resolved.StartsWith($repo + [IO.Path]::DirectorySeparatorChar)) {
        throw "Unsafe test directory: $resolved"
    }
    Remove-Item -LiteralPath $resolved -Recurse -Force
}

function Write-Utf8 {
    param([string]$Path, [string]$Text)
    [IO.File]::WriteAllText($Path, $Text, [Text.UTF8Encoding]::new($false))
}

function Get-TreeFingerprint {
    param([string]$Path)
    return (Get-ChildItem -Recurse -File $Path | Sort-Object FullName | ForEach-Object {
        "$($_.FullName.Substring($Path.Length))=$((Get-FileHash $_.FullName -Algorithm SHA256).Hash)"
    }) -join "`n"
}

try {
    Remove-SafeTemp
    New-Item -ItemType Directory -Path "$temp\new-en", "$temp\new-zh", "$temp\v1\docs", "$temp\v1\prompts", "$temp\partial\docs", "$temp\custom\project", "$temp\invalid" -Force | Out-Null

    Write-Utf8 "$temp\v1\HARNESS.md" "# Existing Harness`n`nCustom project fact: KEEP-ME"
    Write-Utf8 "$temp\v1\AGENTS.md" "# Existing Instructions`n`nCustom rule: KEEP-AGENT"
    Write-Utf8 "$temp\v1\docs\tasks.md" "# Old tasks`n`nTASK-CONTENT"
    Write-Utf8 "$temp\v1\docs\decisions.md" "# Old decisions`n`nDECISION-CONTENT"
    Write-Utf8 "$temp\v1\docs\product.md" "# Product`n`nPRODUCT-CONTENT"
    Write-Utf8 "$temp\v1\docs\sop.md" "# Legacy SOP`n`nSOP-CONTENT"
    Write-Utf8 "$temp\v1\prompts\master.md" "# Legacy prompt`n`nPROMPT-CONTENT"
    Write-Utf8 "$temp\partial\TASKS.md" "# Existing tasks`n`nPARTIAL-TASK-CONTENT"
    Write-Utf8 "$temp\partial\docs\product.md" "# Existing product`n`nPARTIAL-PRODUCT-CONTENT"
    Write-Utf8 "$temp\custom\project\work-items.md" "# Custom tasks`n`nCUSTOM-TASK-CONTENT"
    Write-Utf8 "$temp\custom\project\choices.md" "# Custom decisions`n`nCUSTOM-DECISION-CONTENT"
    Write-Utf8 "$temp\custom\HARNESS.md" @"
# Existing Harness

<!-- project-harness:managed:start -->
## Harness Protocol

- Protocol: 2
- Tasks: ``project/work-items.md``
- Decisions: ``project/choices.md``
<!-- project-harness:managed:end -->
"@

    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\new-en" -Language en | Out-Host
    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\new-zh" -Language zh-CN | Out-Host

    foreach ($name in @('new-en', 'new-zh')) {
        $files = @(Get-ChildItem -Recurse -File "$temp\$name")
        if ($files.Count -ne 4) { throw "$name should contain exactly four initialized files, found $($files.Count)" }
        & "$skill\scripts\validate-project.ps1" -ProjectPath "$temp\$name" | Out-Host
        $language = if ($name -eq 'new-zh') { 'zh-CN' } else { 'en' }
        foreach ($ledger in @('tasks', 'decisions')) {
            $actual = (Get-FileHash -LiteralPath "$temp\$name\docs\$ledger.md").Hash
            $expected = (Get-FileHash -LiteralPath "$skill\assets\minimal-project\$language\docs\$ledger.md").Hash
            if ($actual -ne $expected) { throw "$name did not copy the $ledger template for $language" }
        }
    }

    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\partial" -Language en | Out-Host
    if (Test-Path -LiteralPath "$temp\partial\docs\tasks.md") {
        throw 'Partial adoption duplicated the existing TASKS.md source'
    }
    if (-not (Test-Path -LiteralPath "$temp\partial\docs\decisions.md") -or
        -not (Test-Path -LiteralPath "$temp\partial\HARNESS.md") -or
        -not (Test-Path -LiteralPath "$temp\partial\AGENTS.md")) {
        throw 'Partial adoption did not create the missing governance files'
    }
    $partialInspection = & "$skill\scripts\inspect-project.ps1" -ProjectPath "$temp\partial" | ConvertFrom-Json
    if ($partialInspection.sources.tasks -ne 'TASKS.md') { throw 'Partial task source was not reused' }
    if ($partialInspection.sources.decisions -ne 'docs/decisions.md') { throw 'Missing decision source was not created and mapped' }
    if (-not (Select-String -LiteralPath "$temp\partial\TASKS.md" -Pattern 'PARTIAL-TASK-CONTENT' -Quiet)) {
        throw 'Partial task content was not preserved'
    }
    $partialFirst = Get-TreeFingerprint "$temp\partial"
    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\partial" -Language en | Out-Host
    $partialSecond = Get-TreeFingerprint "$temp\partial"
    if ($partialFirst -cne $partialSecond) { throw 'Partial adoption is not idempotent' }

    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\custom" -Language en | Out-Host
    if ((Test-Path -LiteralPath "$temp\custom\docs\tasks.md") -or
        (Test-Path -LiteralPath "$temp\custom\docs\decisions.md")) {
        throw 'Custom mapped sources were duplicated by default ledgers'
    }
    $customInspection = & "$skill\scripts\inspect-project.ps1" -ProjectPath "$temp\custom" | ConvertFrom-Json
    if ($customInspection.sources.tasks -ne 'project/work-items.md') { throw 'Custom task mapping was not preserved' }
    if ($customInspection.sources.decisions -ne 'project/choices.md') { throw 'Custom decision mapping was not preserved' }
    foreach ($check in @(
        @("$temp\custom\project\work-items.md", 'CUSTOM-TASK-CONTENT'),
        @("$temp\custom\project\choices.md", 'CUSTOM-DECISION-CONTENT')
    )) {
        if (-not [IO.File]::ReadAllText($check[0]).Contains($check[1])) {
            throw "Custom mapped content was not preserved in $($check[0]): $($check[1])"
        }
    }
    $customFirst = Get-TreeFingerprint "$temp\custom"
    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\custom" -Language en | Out-Host
    $customSecond = Get-TreeFingerprint "$temp\custom"
    if ($customFirst -cne $customSecond) { throw 'Custom mapped adoption is not idempotent' }

    & "$skill\scripts\update-project.ps1" -ProjectPath "$temp\invalid" -Language en | Out-Host
    $pwsh = (Get-Process -Id $PID).Path
    & $pwsh -NoLogo -NoProfile -File "$skill\scripts\validate-project.ps1" -ProjectPath "$temp\invalid" *> $null
    if ($LASTEXITCODE -eq 0) { throw 'Validation accepted unresolved task and decision mappings' }

    & "$skill\scripts\update-project.ps1" -ProjectPath "$temp\v1" -Language en | Out-Host
    $first = Get-TreeFingerprint "$temp\v1"
    & "$skill\scripts\update-project.ps1" -ProjectPath "$temp\v1" -Language en | Out-Host
    $second = Get-TreeFingerprint "$temp\v1"
    if ($first -cne $second) { throw 'V1 update is not idempotent' }

    & "$skill\scripts\validate-project.ps1" -ProjectPath "$temp\v1" | Out-Host
    $inspection = & "$skill\scripts\inspect-project.ps1" -ProjectPath "$temp\v1" | ConvertFrom-Json
    if ($inspection.protocol -ne '2') { throw "Unexpected protocol: $($inspection.protocol)" }
    if ($inspection.sources.tasks -ne 'docs/tasks.md') { throw 'Task source map failed' }

    foreach ($check in @(
        @("$temp\v1\HARNESS.md", 'KEEP-ME'),
        @("$temp\v1\AGENTS.md", 'KEEP-AGENT'),
        @("$temp\v1\docs\tasks.md", 'TASK-CONTENT'),
        @("$temp\v1\docs\decisions.md", 'DECISION-CONTENT'),
        @("$temp\v1\docs\sop.md", 'SOP-CONTENT'),
        @("$temp\v1\prompts\master.md", 'PROMPT-CONTENT')
    )) {
        if (-not (Select-String -LiteralPath $check[0] -Pattern $check[1] -Quiet)) {
            throw "Existing content was not preserved: $($check[0])"
        }
    }

    Write-Output 'PASS: Project Harness PowerShell tests'
} finally {
    Remove-SafeTemp
}
