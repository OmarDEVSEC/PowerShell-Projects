#PS script for file managment, and moving around bulk files to intended locations

#Define the source directory where the PDF files are located
$sourceDirectory = "C:\Users\" # Choose whatever directory you want to move files from

#Defining the destination of the directory 
$destinationDirectory = "C:\Users\" # Choose whatever directory you want to move files to

#creating the destination folder if one does not exist
if (-not (Test-Path -Path $destinationDirectory)) {
    New-Item -Path $destinationDirectory -ItemType Directory
}

#Get all the PDF files from the source directory
$pdfFiles = Get-Childitem -Path $sourceDirectory -Filter "*.pdf" -File

#Move each PDF file to the destination directory
foreach ($file in $pdfFiles) {
    $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $file.Name 
    Move-item -Path $file.FullName -Destination $destinationPath -Force
}

Write-Host 
"You have succesfuly moved the PDF files to folder PDFs"