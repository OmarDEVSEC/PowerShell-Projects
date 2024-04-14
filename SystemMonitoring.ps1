#Script To monitor system CPU usage, memory usage, disk space, 

# Define the variables to store thesholds for CPU, DISk, And Memory

$cpuThreshold = 80
$memoryThreshold = 70 
$spaceThreshold = 50

#Variable and code to check CPU Usage

$cpuUsage =  (Get-counter '/Processor(_Total)\% Processor Time').CounterSamples.CookedValue

#Variable and code to check memory usage

$memoryUsage = (Get-Counter '\Memory\% Committed Bytes In Use').CounterSamples.CookedValue