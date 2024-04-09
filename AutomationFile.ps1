#Define the source directory where the PDF files are located
$sourceDirectory = "C:\Users\homar\OneDrive\Desktop\"

#Defining the destination of the directory 
$destinationDirectory = "C:\Users\homar\OneDrive\Desktop\PDFs"

#creating the does not exist
if (-not (Test-Path -Path $destinationDirectory)) {
    New-Item -Path $destinationDirectory -ItemType Directory
}

Write-Host 
"My first script. It Is just a test, thanks I will work hard to complete this automation project."