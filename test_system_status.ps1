# Test script for system_status.sh quick status functionality

function Show-System-Info {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Blue
    Write-Host "        System Information Report       " -ForegroundColor Blue
    Write-Host "========================================" -ForegroundColor Blue
    Write-Host ""

    Write-Host "System Information:" -ForegroundColor Green
    Write-Host "Hostname: $(hostname)"
    $os = Get-CimInstance Win32_OperatingSystem
    Write-Host "OS: $($os.Caption)"
    Write-Host "Kernel: $($os.Version)"
    Write-Host "Architecture: $($env:PROCESSOR_ARCHITECTURE)"
    $uptime = (Get-Date) - ($os.LastBootUpTime)
    Write-Host "Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"
    Write-Host ""

    Write-Host "CPU Information:" -ForegroundColor Green
    $cpu = Get-CimInstance Win32_Processor
    Write-Host "CPU Model: $($cpu.Name)"
    Write-Host "CPU Cores: $($cpu.NumberOfCores)"
    $cpuUsage = Get-CimInstance Win32_PerfFormattedData_PerfOS_Processor | Select-Object -ExpandProperty PercentProcessorTime
    Write-Host "CPU Usage: $cpuUsage%"
    Write-Host ""

    Write-Host "Memory Information:" -ForegroundColor Green
    $memory = Get-CimInstance Win32_OperatingSystem
    $totalMemory = [math]::Round($memory.TotalVisibleMemorySize / 1MB)
    $freeMemory = [math]::Round($memory.FreePhysicalMemory / 1MB)
    $usedMemory = $totalMemory - $freeMemory
    Write-Host "Total: $($totalMemory)MB"
    Write-Host "Used: $($usedMemory)MB"
    Write-Host "Free: $($freeMemory)MB"
    Write-Host ""

    Write-Host "Disk Information:" -ForegroundColor Green
    Get-WmiObject Win32_LogicalDisk | ForEach-Object {
        if ($_.DriveType -eq 3) {
            $size = [math]::Round($_.Size / 1GB, 2)
            $free = [math]::Round($_.FreeSpace / 1GB, 2)
            Write-Host "$($_.DeviceID) Size: $($size)GB, Free: $($free)GB"
        }
    }
    Write-Host ""
}

Show-System-Info