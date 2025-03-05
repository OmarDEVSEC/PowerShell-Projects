#Script To monitor system CPU usage, memory usage, disk space, 

# Define the variables to store thesholds for CPU, DISk, And Memory

$cpuThreshold = 80 #The capacity that is going to trigger an output of CPU
$memoryThreshold = 70  # The capacity that is going to trigger an output of memory
$spaceThreshold = 50 #The capacity that is going to trigger an output of storage space

#Variable and code to check CPU Usage

$cpuUsage =  (Get-counter '/Processor(_Total)\% Processor Time').CounterSamples.CookedValue

#Variable and code to check memory usage
$memory = Get-CimInstance Win32_OperatingSystem
$memoryUsage = (Get-Counter '\Memory\% Committed Bytes In Use').CounterSamples.CookedValue

#Check disk space using disk and diskusage
$disk = Get-PSDrive -PSProvider FileSystem | Where-Object {$_.Used -or $_.Free}
$diskUsage = $disk | ForEach-Object{
    [PSCustomObject]@{
        Drive = $_.Name #Drive letter (e.g. C,D,E)
        FreeSpaceGb = [math]::Round($_.Free / 1GB, 2) #Convert free space to GB with 2 decimal percision
        TotalSpaceGB = [math]::Round($_.Used + $_.Free/ 1GB, 2) #Calculate the total disk space
        UsedPercentage = [math]::Round((($_.Used) / ($_.Used + $_.Free) * 100), 2) #Calculate percentage of used space

    }
}

# Alerts are generated if resource threshold is exceeded

if ($cpuUsage -gt $cpuThreshold){
    Write-Output "Warning: CPU usage is high ($cpuUsage%)"
}

if ($memoryUsage -gt $memoryThreshold){
    write-output "warning: Memory usage is high ($memoryUsage%)"
}

#Each drive will generate an alert if disk usage exceeds threshold
$diskUsage | ForEach-Object{
    if ($_.UsedPercentage -gt $spaceThreshold){
        Write-Output "Warning: Drive $($_.Drive) is $($_.UsedPercentage)% full"
    }

}

#Give the current system status
Write-Output "Current System Status:"
Write-output "CPU usage: $cpuUsage%"
Write-output "Memory usage: $memoryUsage%"
$diskUsage | ForEach-Object{
    Write-Output "Drive $($_.Drive): Free Space: $($_.FreeSpaceGB) GB / Total Space: $($_.TotalSpaceGB) GB ($($_.UsedPercentage)% used)"
}