# Azure DevOps URL Redirector - Build Script
# Creates a production-ready ZIP file for Microsoft Edge Add-ons submission

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ADO Redirector Extension Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$extensionPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$outputFileName = "ADORedirector-v1.0.0.zip"
$outputPath = Join-Path $extensionPath $outputFileName

# Required files for the extension package
$requiredFiles = @(
    "manifest.json",
    "rules.json",
    "icon.png"
)

Write-Host "Validating required files..." -ForegroundColor Yellow

# Check if all required files exist
$missingFiles = @()
foreach ($file in $requiredFiles) {
    $filePath = Join-Path $extensionPath $file
    if (-not (Test-Path $filePath)) {
        $missingFiles += $file
        Write-Host "  ✗ $file - MISSING" -ForegroundColor Red
    } else {
        Write-Host "  ✓ $file" -ForegroundColor Green
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "ERROR: Missing required files!" -ForegroundColor Red
    Write-Host "Cannot create extension package." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "All required files found!" -ForegroundColor Green
Write-Host ""

# Remove existing ZIP if it exists
if (Test-Path $outputPath) {
    Write-Host "Removing existing ZIP file..." -ForegroundColor Yellow
    Remove-Item $outputPath -Force
}

Write-Host "Creating extension package..." -ForegroundColor Yellow

# Create the ZIP file
try {
    # Create a temporary list of full paths for the files to compress
    $filesToCompress = $requiredFiles | ForEach-Object {
        Join-Path $extensionPath $_
    }
    
    # Use .NET compression to create the ZIP
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    
    # Create a new ZIP file
    $zipArchive = [System.IO.Compression.ZipFile]::Open($outputPath, [System.IO.Compression.ZipArchiveMode]::Create)
    
    foreach ($file in $filesToCompress) {
        $entryName = Split-Path $file -Leaf
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zipArchive, $file, $entryName) | Out-Null
        Write-Host "  Added: $entryName" -ForegroundColor Cyan
    }
    
    $zipArchive.Dispose()
    
    Write-Host ""
    Write-Host "✓ Package created successfully!" -ForegroundColor Green
    Write-Host ""
    
    # Display file information
    $zipInfo = Get-Item $outputPath
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Package Information" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "File: $outputFileName" -ForegroundColor White
    Write-Host "Location: $($zipInfo.FullName)" -ForegroundColor White
    Write-Host "Size: $([math]::Round($zipInfo.Length / 1KB, 2)) KB" -ForegroundColor White
    Write-Host ""
    Write-Host "This ZIP file is ready to upload to:" -ForegroundColor Yellow
    Write-Host "  Partner Center > Extensions > Upload Package" -ForegroundColor White
    Write-Host "  https://partner.microsoft.com/dashboard/microsoftedge/" -ForegroundColor Cyan
    Write-Host ""
    
    # Ask if user wants to open the folder
    $openFolder = Read-Host "Open containing folder? (Y/n)"
    if ($openFolder -ne 'n' -and $openFolder -ne 'N') {
        Start-Process "explorer.exe" -ArgumentList "/select,`"$outputPath`""
    }
    
} catch {
    Write-Host ""
    Write-Host "ERROR: Failed to create ZIP file!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host "Build complete!" -ForegroundColor Green
Write-Host ""
