#Define the source directory where the PDF files are located
<<<<<<< HEAD
$sourceDirectory = "C:\Users\homar\OneDrive\Desktop\"

#Defining the destination of the directory 
$destinationDirectory = "C:\Users\homar\OneDrive\Desktop\PDFs"

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
=======
$sourceDirectory = 



Write-Host 
"My first script. It Is just a test, thanks I will work hard to complete this automation project."
>>>>>>> 8abc308 (Defining CPU, DISK, AND STORAGE Thresholds)
