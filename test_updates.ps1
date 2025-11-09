# Test script for updates.sh cleanup functionality
$DRY_RUN = $true
$LOG_DIR = "C:\Users\Chinmayee Sahu\Documents\capstoneproject\test_logs"
$CLEANUP_LOG = "$LOG_DIR\cleanup.log"

function Info-Message {
    param ([string]$Message)
    Write-Host "INFO: $Message"
}

function Success-Message {
    param ([string]$Message)
    Write-Host "SUCCESS: $Message"
}

function Clean-Temp-Files {
    Info-Message "Cleaning temporary files..."
    $tempDirs = @($env:TEMP, $env:SystemRoot + "\Temp")
    foreach ($tempDir in $tempDirs) {
        if (Test-Path $tempDir) {
            if ($DRY_RUN) {
                Write-Host "DRY RUN: Would have cleaned files in $tempDir"
            } else {
                # Get-ChildItem -Path $tempDir -Recurse | Where-Object { $_.LastAccessTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse
            }
        }
    }
    Success-Message "Temporary files cleaned"
}

function Clean-Old-Logs {
    param ([int]$log_retention_days = 30)
    Info-Message "Cleaning old log files (retention: $log_retention_days days)..."
    $logDirs = @("C:\Users\Chinmayee Sahu\Documents\capstoneproject\test_logs")
    foreach ($logDir in $logDirs) {
        if (Test-Path $logDir) {
            if ($DRY_RUN) {
                Write-Host "DRY RUN: Would have cleaned logs in $logDir older than $log_retention_days days"
            } else {
                # Get-ChildItem -Path $logDir -Recurse -Include "*.log" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$log_retention_days) } | Remove-Item -Force
            }
        }
    }
    Success-Message "Old log files cleaned"
}

Clean-Temp-Files
Clean-Old-Logs