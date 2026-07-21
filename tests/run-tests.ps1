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
    New-Item -ItemType Directory -Path "$temp\new-en", "$temp\new-zh", "$temp\v1\docs", "$temp\v1\prompts" -Force | Out-Null

    $skillInstructions = [IO.File]::ReadAllText((Join-Path $skill 'SKILL.md'))
    foreach ($expected in @(
        'starts or resumes a project',
        'Do not require the user to name the skill',
        'Explicitly apply Project Harness'
    )) {
        if (-not $skillInstructions.Contains($expected)) {
            throw "Missing activation contract in SKILL.md: $expected"
        }
    }

    Write-Utf8 "$temp\v1\HARNESS.md" "# Existing Harness`n`nCustom project fact: KEEP-ME"
    Write-Utf8 "$temp\v1\AGENTS.md" "# Existing Instructions`n`nCustom rule: KEEP-AGENT"
    Write-Utf8 "$temp\v1\docs\tasks.md" "# Old tasks`n`nTASK-CONTENT"
    Write-Utf8 "$temp\v1\docs\decisions.md" "# Old decisions`n`nDECISION-CONTENT"
    Write-Utf8 "$temp\v1\docs\product.md" "# Product`n`nPRODUCT-CONTENT"
    Write-Utf8 "$temp\v1\docs\sop.md" "# Legacy SOP`n`nSOP-CONTENT"
    Write-Utf8 "$temp\v1\prompts\master.md" "# Legacy prompt`n`nPROMPT-CONTENT"

    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\new-en" -Language en | Out-Host
    & "$skill\scripts\init-project.ps1" -ProjectPath "$temp\new-zh" -Language zh-CN | Out-Host

    foreach ($name in @('new-en', 'new-zh')) {
        $files = @(Get-ChildItem -Recurse -File "$temp\$name")
        if ($files.Count -ne 4) { throw "$name should contain exactly four initialized files, found $($files.Count)" }
        & "$skill\scripts\validate-project.ps1" -ProjectPath "$temp\$name" | Out-Host
    }

    if (-not (Select-String -LiteralPath "$temp\new-en\AGENTS.md" -Pattern 'Infer project intent from ordinary language' -Quiet)) {
        throw 'English project entry does not enable semantic activation'
    }
    if (-not (Select-String -LiteralPath "$temp\new-zh\AGENTS.md" -Pattern '根据日常表达判断项目意图' -Quiet)) {
        throw 'Chinese project entry does not enable semantic activation'
    }

    & "$skill\scripts\update-project.ps1" -ProjectPath "$temp\v1" -Language en | Out-Host
    $first = Get-TreeFingerprint "$temp\v1"
    & "$skill\scripts\update-project.ps1" -ProjectPath "$temp\v1" -Language en | Out-Host
    $second = Get-TreeFingerprint "$temp\v1"
    if ($first -cne $second) { throw 'V1 update is not idempotent' }

    & "$skill\scripts\validate-project.ps1" -ProjectPath "$temp\v1" | Out-Host
    $inspection = & "$skill\scripts\inspect-project.ps1" -ProjectPath "$temp\v1" | ConvertFrom-Json
    if ($inspection.protocol -ne '2') { throw "Unexpected protocol: $($inspection.protocol)" }
    if ($inspection.sources.tasks -ne 'docs/tasks.md') { throw 'Task source map failed' }
    if (-not (Select-String -LiteralPath "$temp\v1\AGENTS.md" -Pattern 'Infer project intent from ordinary language' -Quiet)) {
        throw 'Updated project entry does not enable semantic activation'
    }

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
