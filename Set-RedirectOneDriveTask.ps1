<#
.SYNOPSIS
    Creates a scheduled task to enable folder redirection into OneDrive
.NOTES
	Forked from: https://gist.github.com/aaronparker/eb8f03f7a2ab4027ffdff556a952502b
#>

# Variables
$Url = "https://raw.githubusercontent.com/TriaTech/IntuneScripts/master/Redirect-FoldersOneDrive.ps1"
$Target = "$env:ProgramData\Scripts"
$Script = "Redirect-FoldersOneDrive.ps1"

Start-Transcript -Path "$Target\Set-RedirectOneDriveTask-ps1.log"

# If local path for script doesn't exist, create it
If (!(Test-Path $Target)) { New-Item -Path $Target -Type Directory -Force }

# Download the script from the source repository
If (Test-Path "$Target\$Script") { Remove-Item -Path "$Target\$Script" -Force }
Start-BitsTransfer -Source $Url -Destination "$Target\$Script"

# Create the scheduled task to run the script at logon
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-ExecutionPolicy Bypass -NonInteractive -WindowStyle Hidden -File $Target\$Script"
$trigger =  New-ScheduledTaskTrigger -AtLogon -RandomDelay (New-TimeSpan -Minutes 1)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -Hidden -DontStopIfGoingOnBatteries -Compatibility Win8
$principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Users"
$task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal
Register-ScheduledTask -InputObject $task -TaskName "Redirect Folders to OneDrive"

Stop-Transcript
