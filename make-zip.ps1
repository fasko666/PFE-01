# ============================================================
#  PANDA — Create Distributable ZIP
#  Produces a clean zip that anyone can unzip + run with
#  setup.ps1 → START.bat
#
#  Usage: Right-click → "Run with PowerShell"
#         OR: .\make-zip.ps1
# ============================================================

$ROOT    = Split-Path $MyInvocation.MyCommand.Path
$zipPath = Join-Path $ROOT "PANDA-project.zip"

Write-Host ""
Write-Host "  Building clean ZIP of PANDA project..." -ForegroundColor Cyan
Write-Host "  Output: $zipPath" -ForegroundColor Gray
Write-Host ""

# Folders / files to EXCLUDE from the zip
$exclude = @(
    "vendor",
    "node_modules",
    ".git",
    ".github",
    "PANDA-project.zip",
    "*.log",
    "storage\framework\cache",
    "storage\framework\sessions",
    "storage\framework\views",
    "storage\logs"
)

# Collect all files, skipping excluded paths
$files = Get-ChildItem -Path $ROOT -Recurse -File | Where-Object {
    $rel  = $_.FullName.Substring($ROOT.Length + 1)
    $skip = $false
    foreach ($ex in $exclude) {
        if ($rel -like "*$ex*") { $skip = $true; break }
    }
    -not $skip
}

Write-Host "  Files to include: $($files.Count)" -ForegroundColor Gray

# Create / update the zip (Update mode handles overwriting an existing file)
Add-Type -AssemblyName System.IO.Compression.FileSystem
$mode = if (Test-Path $zipPath) { 'Update' } else { 'Create' }
$zip  = [System.IO.Compression.ZipFile]::Open($zipPath, $mode)

foreach ($file in $files) {
    $entryName = "PANDA\" + $file.FullName.Substring($ROOT.Length + 1)
    $existing  = $zip.Entries | Where-Object { $_.FullName -eq $entryName }
    if ($existing) { $existing.Delete() }
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
        $zip, $file.FullName, $entryName,
        [System.IO.Compression.CompressionLevel]::Optimal
    ) | Out-Null
}

$zip.Dispose()

$sizeMB = [math]::Round((Get-Item $zipPath).Length / 1MB, 1)

Write-Host ""
Write-Host "  Done! ZIP created:" -ForegroundColor Green
Write-Host "  $zipPath  ($sizeMB MB)" -ForegroundColor Cyan
Write-Host ""
Write-Host "  The recipient needs to:" -ForegroundColor Yellow
Write-Host "  1. Install: PHP 8.2+, Composer, Node.js, MySQL" -ForegroundColor Gray
Write-Host "  2. Unzip the PANDA folder anywhere" -ForegroundColor Gray
Write-Host "  3. Run setup.ps1 (right-click → Run with PowerShell)" -ForegroundColor Gray
Write-Host "  4. Double-click START.bat" -ForegroundColor Gray
Write-Host ""

# Open the containing folder in Explorer
Start-Process explorer.exe $ROOT

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
