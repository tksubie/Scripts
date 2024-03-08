#script to install programs on USB drive using .msi installers and .exe.

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


#Software Install
echo "`nSoftware Example"

DO {
    $a = Read-Host "Do you need Software Example? Y / N: "
} Until ( 'y', 'n','Y','N' -contains $a ) 

if($a -match 'Y' -or $a -match 'y'){

    Write-Progress -Activity "Opening SoftwareExampleSetup" -Status "Task 1 of 2" -PercentComplete 100
	try {
		Start-Process msiexec.exe -Wait -ArgumentList '/I "$USBDrive`:\xx\SoftwareExampleSetup.msi" /quiet /passive'
	}
	catch { "Error occured, Open Installer failed." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Installed" }
    Start-Sleep -Seconds 1
$ErrorOccured = $false

echo "--`n"
}

#Software Example .exe
echo "`nSuper Drive Driver"

DO {
    $a = Read-Host "Do you need the Software Example .exe installed? Y / N: "
} Until ( 'y', 'n','Y','N' -contains $a ) 

if($a -match 'Y' -or $a -match 'y'){

    Write-Progress -Activity "Opening SoftwareExampleSetup" -Status "Task 1 of 2" -PercentComplete 100
	try {cd "$USBDrive`:\xxx\xxx\xxxxx\xxxxx\xxxx" -ErrorAction Stop
		.\SoftwareSetup
	}
	catch { "Error occured, Open Installer failed." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Installer Opened" }
    Start-Sleep -Seconds 1
$ErrorOccured = $false

echo "--`n"
}



Read-Host -Prompt "`nScript Complete! - Press Enter to exit"		#to not exit right after execution