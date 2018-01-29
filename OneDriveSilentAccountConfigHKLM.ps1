$KeyPath = "HKLM:\Software\Policies\Microsoft"
$KeyName = "OneDrive"
$KeyFullPath = $KeyPath + "\" + $KeyName
$Name = "SilentAccountConfig"
$value = "1"
New-Item -Path $KeyPath -Name $KeyName -ErrorAction SilentlyContinue
New-ItemProperty -Path $KeyFullPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null