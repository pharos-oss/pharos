<#
=====================================
setup.ps1
Made By: Gianmarco Raimondi
Date: 18/11/2026
This script automatically installs the necessary tools for the Pharos project.
=====================================
#>

$ColorInfo = "Cyan"
$ColorSuccess = "Green"
$ColorWarning = "Yellow"

$ErrorActionPreference = "Stop"

Write-Host "Starting initial setup...`n" -ForegroundColor $ColorInfo

if (Get-Command just -ErrorAction SilentlyContinue) {
    Write-Host "✓ Just is already installed.`n" -ForegroundColor $ColorSuccess
} else {
    Write-Host "Just not found. Installing via Winget..." -ForegroundColor $ColorWarning
    winget install --id Casey.Just --exact --accept-package-agreements --accept-source-agreements
    Write-Host "✓ Just successfully installed.`n" -ForegroundColor $ColorSuccess
}

if (Get-Command prek -ErrorAction SilentlyContinue) {
    Write-Host "✓ prek is already installed.`n" -ForegroundColor $ColorSuccess
} else {
    Write-Host "prek not found. Installing via Winget..." -ForegroundColor $ColorWarning
    winget install --id j178.Prek --accept-package-agreements --accept-source-agreements
    Write-Host "✓ prek successfully installed.`n" -ForegroundColor $ColorSuccess
}

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "Initializing git hooks..." -ForegroundColor $ColorInfo
if (Test-Path ".pre-commit-config.yaml") {
    prek install
    Write-Host "✓ Git hooks successfully installed." -ForegroundColor $ColorSuccess
} else {
    Write-Host "Warning: .pre-commit-config.yaml not found. Please ensure you are in the project root." -ForegroundColor $ColorWarning
}

# I've never written in ps before, it's kinda cool