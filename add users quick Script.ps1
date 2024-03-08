#Create users quick

#run as administrator, elevate powershell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#error variable
$ErrorOccured = $false

#new preset 
DO {
    $a = Read-Host "Do you need a preset account? Y / N: "
} Until ( 'y', 'n','Y','N' -contains $a ) 

if($a -match 'Y' -or $a -match 'y'){

    Write-Progress -Activity "Adding Account..." -Status "Task 1 of 2" -PercentComplete 100
	try {net user preset /add /active:yes}
	catch {"Error occured, Account Creation failed." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Account made" }
    Start-Sleep -Seconds 1
$ErrorOccured = $false

echo "--`n"
}


#new Sub Account
DO {
    $a = Read-Host "Do you need a Sub account? Y / N: "
} Until ( 'y', 'n','Y','N' -contains $a ) 

if($a -match 'Y' -or $a -match 'y'){

    Write-Progress -Activity "Adding Account..." -Status "Task 1 of 2" -PercentComplete 100
	try {net user Sub /add /active:yes}
	catch {"Error occured, Account Creation failed." 
		$ErrorOccured=$true}
	if (!$ErrorOccured) { "Account made" }
    Start-Sleep -Seconds 1
$ErrorOccured = $false

echo "--`n"
}



Read-Host -Prompt "`nScript Complete! - Press Enter to exit"		#to not exit right after execution