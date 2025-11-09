# Test script for log_monitor.sh disk space monitoring functionality

function Info-Message {
    param ([string]$Message)
    Write-Host "INFO: $Message"
}

function Monitor-Disk-Space {
    $warning_threshold = 80
    $critical_threshold = 90
    $alert_messages = ""
    $alert_count = 0

    Info-Message "Monitoring disk space..."

    $disks = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }

    foreach ($disk in $disks) {
        $filesystem = $disk.DeviceID
        $size = $disk.Size
        $free = $disk.FreeSpace
        $used = $size - $free
        $use_percent = [math]::Round(($used / $size) * 100)

        if ($use_percent -ge $critical_threshold) {
            $alert_messages += "CRITICAL: Disk usage at $($use_percent)% on $filesystem`n"
            $alert_count++
        } elseif ($use_percent -ge $warning_threshold) {
            $alert_messages += "WARNING: Disk usage at $($use_percent)% on $filesystem`n"
            $alert_count++
        }
    }

    if ($alert_count -gt 0) {
        Write-Host "Disk Space Alert on $(hostname)"
        Write-Host "Disk space issues detected:`n"
        Write-Host $alert_messages
    }

    Info-Message "Disk space monitoring completed. Found $alert_count alerts"
}

Monitor-Disk-Space