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

