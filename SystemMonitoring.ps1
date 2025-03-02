#Script To monitor system CPU usage, memory usage, disk space, 

# Define the variables to store thesholds for CPU, DISk, And Memory

$cpuThreshold = 80 #The capacity that is going to trigger an output of CPU
$memoryThreshold = 70 
$spaceThreshold = 50

#Variable and code to check CPU Usage

$cpuUsage =  (Get-counter '/Processor(_Total)\% Processor Time').CounterSamples.CookedValue

#Variable and code to check memory usage
$memory = Get-CimInstance 
$memoryUsage = (Get-Counter '\Memory\% Committed Bytes In Use').CounterSamples.CookedValue
