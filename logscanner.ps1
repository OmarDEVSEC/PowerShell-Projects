#Log scanner script. Best use cases: Takes parameters for log directory path,
#outputfile, and search patterns
# Scans text-based log files (*.log *.txt), searches for common security incident indicators
#outputs findings to a CSV file
# Run script with a command .\logscanner.ps1 -LogPath "C:\Logs"

#defining script parameters
param(
    #Parameter contianing path to the directory containing log files
    [Parameter(Mandatory=$true)]
    [string]$LogPath,

    #file path for the CSV output including timestamp -default name
    # Parameter help description
    [Parameter(Mandatory=$false)]
    [String]$OutputFile = "SecurityIncidents_$(Get-Date -Format 'yyyyMMdd').CSV",

    #Array of patterns to search in logs pulled
    [Parameter(Mandatory=$false)]
    [string[]]$Patterns = @(
        "failed loging","authentication failure","access denied",
        "firewall block","malware","suspicious", "brute force"    
        )
)

#Check if log directory exists
if (-not(Test-Path -Path $LogPath)){
    Write-Host "Error: Directory not found: $LogPath" #Lets user know that log directory does not exist
    exit 1
}

#Gather log file common extensions
$LogFiles = Get-ChildItem -Path $LogPath -Recurse -Include *.log,*.txt,*.csv,*.evt,*.evtx

Write-Host "Scanning $($LogFiles.Count)log files..."


#Create an Array for results
$Results = @()

#For processing each log file 
Foreach ($LogFile in $LogFiles){
    if($LogFile.Length -eq 0) {continue} #This line skips empty files

#Reads the file content
$Content = Get-Content -Path $LogFile.FullName -Raw -ErrorAction SilentlyContinue
if($null -eq $Content) {continue} #Skips if file cannot be read

#Look for patterns in the file
foreach($Pattern in $Patterns){
    $Matches = Select-String -InputObject $Content -Pattern $Pattern -AllMatches

    if ($Matches.Matches.Count -gt 0){
        foreach ($Match in $Matches.Matches){
            #Lets add to results
            $Results += [PSCustomObject]@{
                DateTime = Get-Date -Format "yyyy-MM-dd- HH:mm:ss"
                LogFile = $LogFile.FullName
                Pattern = $Pattern
                MatchText = $Match.Value
            }

            }
        }
    }
}

#Finally export logs and return the redsult from scanner script
if($Results.Count -gt 0){
    $Results | Export-Csv -Path $OutputFile -NoTypeInformation #Exports results to the output path
    Write-Host "Found $($Results.Count) incidents. Results saved to $OutputFile"
    return $Results
} else{
    Write-Host "No Security Incidents Found."
}
