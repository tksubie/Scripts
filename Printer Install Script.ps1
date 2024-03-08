# printer script to install a list of printers using a USB Drive with the driver
# a function could be possibly made to call the code only once,, however I just copy and pasted the code to add more printers as I needed.

#Color the loading bar
$host.privatedata.ProgressForegroundColor = "white";
$host.privatedata.ProgressBackgroundColor = "black";

#run as administrator, elevate powershell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Error variable
$ErrorOccured = $false

#Get USB Drive Letter
$USBDrives = Get-WmiObject Win32_Volume -Filter "DriveType='2'"
if ($USBDrives  -is [system.array]){
    $USBDrive = $USBDrives[0].DriveLetter.Substring(0,1)
}else{
    $USBDrive = $USBDrives.DriveLetter.Substring(0,1)
}

echo "Your USB drive letter is = $USBDrive`:"

#add driver to store
Pnputil /add-driver "$USBDrive`:\driver_folder xx\xx\xx\driver.inf"


#Install Universal Driver
    Write-Progress -Activity "Installing Universal Driver for Printers" -Status "Task 1 of 1" -PercentComplete 100
	#install
	Add-PrinterDriver -Name "Driver name"
    Start-Sleep -Seconds 2


#Printer 1
echo "`nPrinter 1"

DO {
    $a = Read-Host "Do you need the Printer 1? Y / N: "
} Until ( 'y', 'n','Y','N' -contains $a ) 

if($a -match 'Y' -or $a -match 'y'){

    Write-Progress -Activity "Creating Port - IP_xx.xx.x.xx" -Status "Task 1 of 2" -PercentComplete 50
	try {add-printerport -name "IP_xx.xx.x.x" -printerhostaddress "xx.xx.x.xx" -ErrorAction Stop}
	catch { "Error occured, port fail, possibly already made." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Port made - IP_xx.xx.x.xx" }
    Start-Sleep -Seconds 1
$ErrorOccured = $false

    Write-Progress -Activity "Adding Printer - Printer 1" -Status "Task 2 of 2" -PercentComplete 100
	try {add-printer -name "HS LMC" -drivername "Driver Name" -port "IP_xx.xx.x.xx" -ErrorAction Stop}
	catch { "Error occured, printer may already be installed." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Printer installed! - HS LMC" }
    Start-Sleep -Seconds 1
echo "--`n"
$ErrorOccured = $false
}



#Printer 1
echo "`nPrinter 2"

DO {
    $a = Read-Host "Do you need the Printer 2? Y / N: "
} Until ( 'y', 'n','Y','N' -contains $a ) 

if($a -match 'Y' -or $a -match 'y'){

    Write-Progress -Activity "Creating Port - IP_xx.xx.x.xx" -Status "Task 1 of 2" -PercentComplete 50
	try {add-printerport -name "IP_xx.xx.x.x" -printerhostaddress "xx.xx.x.xx" -ErrorAction Stop}
	catch { "Error occured, port fail, possibly already made." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Port made - IP_xx.xx.x.xx" }
    Start-Sleep -Seconds 1
$ErrorOccured = $false

    Write-Progress -Activity "Adding Printer - Printer 2" -Status "Task 2 of 2" -PercentComplete 100
	try {add-printer -name "HS LMC" -drivername "Driver Name" -port "IP_xx.xx.x.xx" -ErrorAction Stop}
	catch { "Error occured, printer may already be installed." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Printer installed! - HS LMC" }
    Start-Sleep -Seconds 1
echo "--`n"
$ErrorOccured = $false
}





Read-Host -Prompt "`nScript Complete! - Press Enter to exit"		#to not exit right after execution