$KeyPath = "HKCU:\SOFTWARE\Microsoft"
$KeyName = "OneDrive"
$KeyFullPath = $KeyPath + "\" + $KeyName
$Name = "EnableADAL"
$value = "1"
New-Item -Path $KeyPath -Name $KeyName -SilentlyContinue
New-ItemProperty -Path $KeyFullPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null