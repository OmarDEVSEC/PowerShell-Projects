#Sscript to rename Acitve Directory groups within a specific OU and DCs

Import-Module ActiveDirectory

#path to output CSV file 
$pathoutPut = "C:\IntendedPath"

#path where groups are contained
$OuPath = "OU=Security Groups,OU=Groups,DC="

#find which groups to rename

$Groups = Get-AdGroup -Filter "Name -like 'groupname*'" -SearchBasr $OuPath -Properties Description