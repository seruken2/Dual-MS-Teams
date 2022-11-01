#Copying MS teams profile
Copy-Item -Path "$env:LOCALAPPDATA\Microsoft\Teams\" -Destination "C:\Teams" -Recurse -Container 

#Create a new profile
$password = "782jbjKDKH23bd23%32kgh"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
New-LocalUser -Name "teams" -Password $secureStringPwd -FullName "MS teams" -Description "2nd Teams Account"

#Create Powershell File
$username = '$username'
$password = '$password'
$secureStringPwd = '$secureStringPwd'
$creds = '$creds'
$text = @" 
$username = "teams"
$password = "782jbjKDKH23bd23%32kgh"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd
Start-Process -filepath "C:\Teams\Update.exe" '--processStart "Teams.exe"' -Credential $creds
"@ | Out-File -FilePath C:\Teams\MSTeams.ps1

#Creating a shortcut on Desktop
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$home\Desktop\2ndMSTeams.lnk")
$Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -File C:\Teams\MSTeams.ps1"
$Shortcut.IconLocation = "C:\Teams\app.ico"
$Shortcut.WorkingDirectory = "C:\WINDOWS\System32\WindowsPowerShell\v1.0"
$Shortcut.Save()
