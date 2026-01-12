# Azure DevOps URL Redirector - Installation Script
# This script will open Edge to the extensions page and guide you through installation

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ADO Redirector Extension Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$extensionPath = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Extension location:" -ForegroundColor Yellow
Write-Host "  $extensionPath" -ForegroundColor White
Write-Host ""

Write-Host "Opening Microsoft Edge extensions page..." -ForegroundColor Green
Start-Process "msedge.exe" -ArgumentList "edge://extensions/"
Start-Sleep -Seconds 2

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Manual Installation Steps:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. " -NoNewline -ForegroundColor Yellow
Write-Host "Enable 'Developer mode' (toggle in bottom-left corner)"
Write-Host ""
Write-Host "2. " -NoNewline -ForegroundColor Yellow
Write-Host "Click 'Load unpacked' button"
Write-Host ""
Write-Host "3. " -NoNewline -ForegroundColor Yellow
Write-Host "Navigate to and select this folder:"
Write-Host "   $extensionPath" -ForegroundColor White
Write-Host ""
Write-Host "4. " -NoNewline -ForegroundColor Yellow
Write-Host "Click 'Select Folder'"
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$openFolder = Read-Host "Open extension folder in Explorer? (Y/n)"
if ($openFolder -ne 'n' -and $openFolder -ne 'N') {
    Write-Host "Opening folder..." -ForegroundColor Green
    Start-Process "explorer.exe" -ArgumentList $extensionPath
}

Write-Host ""
Write-Host "Installation complete once you follow the steps above!" -ForegroundColor Green
Write-Host "Test with any URL like: https://myorg.visualstudio.com/myproject" -ForegroundColor Cyan
Write-Host ""
