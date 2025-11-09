# Test script for view_logs.sh --view-system functionality

function View-System-Logs {
    Write-Host "Viewing System Logs..."
    Get-EventLog -LogName System -Newest 5 | Format-Table -Wrap
}

View-System-Logs