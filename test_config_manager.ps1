# Test script for config_manager.sh show configuration functionality

function Show-Configuration {
    $configFile = "C:\Users\Chinmayee Sahu\Documents\capstoneproject\test_config\test_config.conf"

    if (Test-Path $configFile) {
        Write-Host "Current Configuration ($configFile):"
        Get-Content $configFile | ForEach-Object {
            if ($_ -match "^#") {
                Write-Host $_ -ForegroundColor Yellow
            } elseif ($_ -match "=") {
                $key = $_.Split('=')[0]
                $value = $_.Split('=')[1]
                Write-Host "$key=" -NoNewline
                Write-Host $value -ForegroundColor Cyan
            } else {
                Write-Host $_ 
            }
        }
    } else {
        Write-Host "Configuration file not found: $configFile" -ForegroundColor Red
    }
}

Show-Configuration