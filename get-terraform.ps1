##  This script will download a specified version of terraform and then copy it to ##
##  ~\AppData\Local\Microsoft\WindowsApps which is in the PATH env variable.       ##
##                                                                                 ##
##  Author : D. Wilson                                                             ## 


# Variables
$version = read-host "Input your desired terraform release (e.g 0.13.4)"
$url = "https://releases.hashicorp.com/terraform/{0}/terraform_{0}_windows_amd64.zip" -f $version
$OutputFolder = "~\Downloads\terraform\versions\{0}\" -f $version
$OutputFile = "~\Downloads\terraform\versions\{0}\terraform.zip" -f $version # Downloaded file
$terraform = "~\Downloads\terraform\versions\{0}\terraform.exe" -f $version  # Unzipped terraform.exe

# Checking if the specified version already exists, if so copying to the %PATH%
If (Test-Path -Path $terraform ) { 
    Copy-Item -Path $terraform -Destination ~\AppData\Local\Microsoft\WindowsApps -Force
    Write-Host "version already installed, copying to %PATH%"
}

# If the specified version doesn't exist, the .zip is downloaded form hashicorp, extracted and terraform
# is copied to the %PATH%.
else {
    mkdir $OutputFolder
    Write-Host "Downloading requested version of terraform, then copying to %PATH%"
    Invoke-WebRequest -Uri $url -OutFile $OutputFile
    Expand-Archive -LiteralPath $OutputFile -DestinationPath $OutputFolder
    Remove-Item $OutputFile
    Copy-Item -Path $terraform -Destination ~\AppData\Local\Microsoft\WindowsApps -Force
}

write-host "Double checking your version..."

terraform -version