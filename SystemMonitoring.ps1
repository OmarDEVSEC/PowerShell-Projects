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
