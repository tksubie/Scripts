#To make the name of the user or person using the preset account

#run as administrator, elevate powershell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$user_name = Read-Host "User to be assigned to this PC "

#password to be set to be a general password and then changed by the user later
$pass = "password"

#rename account
Rename-LocalUser -Name "preset" -NewName "$user_name"

#set a general account password
net user "$user_name" $pass


echo "`nName changed and account password set!"

Read-Host -Prompt "`nScript Complete! - Press Enter to exit"		#to not exit right after execution