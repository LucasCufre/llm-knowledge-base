#
# setup-links.ps1 - Create AI tool configuration links (cross-platform PowerShell)
#
# On Windows: creates file copies (always works, no admin needed)
# On macOS/Linux: creates symlinks
#
# Usage:
#   PowerShell:  .\scripts\setup-links.ps1
#   Force copy:  .\scripts\setup-links.ps1 -ForceCopy
#

param(
    [switch]$ForceCopy
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$SourceFile = Join-Path $ProjectRoot "CLAUDE.md"

if (-not (Test-Path $SourceFile)) {
    Write-Error "CLAUDE.md not found at $SourceFile"
    exit 1
}

# Determine mode: copy on Windows, symlink on Unix (unless forced)
$IsWindows_ = ($env:OS -eq "Windows_NT") -or ($PSVersionTable.PSVersion -and $IsWindows)
$UseCopy = $IsWindows_ -or $ForceCopy

function New-LinkOrCopy {
    param(
        [string]$Target,
        [string]$LinkPath
    )

    $LinkDir = Split-Path -Parent $LinkPath

    # Ensure parent directory exists
    if (-not (Test-Path $LinkDir)) {
        New-Item -ItemType Directory -Path $LinkDir -Force | Out-Null
    }

    # Remove existing file/link
    if (Test-Path $LinkPath) {
        Remove-Item $LinkPath -Force
    }

    $FileName = Split-Path -Leaf $LinkPath

    if ($UseCopy) {
        Copy-Item $SourceFile $LinkPath
        Write-Host "  Copied  -> $FileName"
    }
    else {
        # On Unix with PowerShell, create symlink
        New-Item -ItemType SymbolicLink -Path $LinkPath -Target $Target | Out-Null
        Write-Host "  Linked  -> $FileName -> $Target"
    }
}

Write-Host "Setting up AI tool configuration files..."
Write-Host "Source: CLAUDE.md"
if ($UseCopy) {
    Write-Host "Mode: copy (Windows-compatible)"
}
else {
    Write-Host "Mode: symlink"
}
Write-Host ""

# Root-level links
New-LinkOrCopy -Target "CLAUDE.md" -LinkPath (Join-Path $ProjectRoot ".cursorrules")
New-LinkOrCopy -Target "CLAUDE.md" -LinkPath (Join-Path $ProjectRoot ".clinerules")
New-LinkOrCopy -Target "CLAUDE.md" -LinkPath (Join-Path $ProjectRoot ".windsurfrules")
New-LinkOrCopy -Target "CLAUDE.md" -LinkPath (Join-Path $ProjectRoot "instructions.md")

# Nested links
New-LinkOrCopy -Target (Join-Path ".." "CLAUDE.md") -LinkPath (Join-Path $ProjectRoot ".continue" "instructions.md")
New-LinkOrCopy -Target (Join-Path ".." "CLAUDE.md") -LinkPath (Join-Path $ProjectRoot ".gemini" "instructions.md")

Write-Host ""
Write-Host "Done! All AI tool config files are set up."
if ($UseCopy) {
    Write-Host ""
    Write-Host "Note: Files were copied. If you update CLAUDE.md, run this script"
    Write-Host "again to sync changes to all tool config files."
}
