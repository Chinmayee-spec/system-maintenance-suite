# Main Test Suite for Windows

# Get the script's directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Test System Status
Write-Host "Testing System Status..."
powershell.exe -File "$ScriptDir\test_system_status.ps1"

# Test View Logs
Write-Host "Testing View Logs..."
powershell.exe -File "$ScriptDir\test_view_logs.ps1"

Write-Host "All tests completed."