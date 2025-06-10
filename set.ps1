<#
.SYNOPSIS
    Устанавливает расширения VS Code и копирует настройки из файла extensions.txt и settings.json
#>

$ExtensionsFile = "extensions.txt"
$VSCodeSettingsDir = "$env:APPDATA\Code\User"

# Проверяем наличие файла с расширениями
if (-not (Test-Path -Path $ExtensionsFile)) {
    Write-Host "[ERR] Extensions file not found" -ForegroundColor Red
    exit 1
}

Write-Host "[STEP] Installing extensions:" -ForegroundColor Green

# Устанавливаем расширения из файла
Get-Content $ExtensionsFile | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith("#")) {
        Write-Host "[INSTALL] Installing: $line" -ForegroundColor Cyan
        code --install-extension $line --force
    }
}

# Копируем файл настроек если он существует
if (Test-Path -Path ".\settings.json") {
    Write-Host "[COPY] Copying settings.json" -ForegroundColor Green
    
    # Создаем директорию если её нет
    if (-not (Test-Path -Path $VSCodeSettingsDir)) {
        New-Item -ItemType Directory -Path $VSCodeSettingsDir | Out-Null
    }
    
    Copy-Item -Path ".\settings.json" -Destination "$VSCodeSettingsDir\settings.json" -Force
}

Write-Host "Done!" -ForegroundColor Green