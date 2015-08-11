Get-ADComputer -Filter * -SearchBase "OU=MY OU,DC=MYDOMAIN,DC=COM" | fl -Property Name > C:\raw.txt
﻿Write-Host "THIS MUST BE RUN AS AN ADMINISTRATOR"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Remove-Item "C:\drivemaps.txt" -EA SilentlyContinue

Get-ADComputer -Filter * -SearchBase "OU=MY OU,DC=DOMAIN,DC=COM" | fl -Property Name > C:\raw.txt
Get-Content C:\raw.txt | ForEach-Object {$_ -replace 'Name : ',''} | Set-Content "C:\raw2.txt"

Select-String -Pattern "\w" -Path C:\raw2.txt |
    ForEach-Object { $_.line } |
    Set-Content C:\adcomputers.txt
   
$computerlist = Get-Content C:\adcomputers.txt
    
    ForEach ($computer in $computerlist)
        
        {

           Get-WmiObject Win32_MappedLogicalDisk -ComputerName $Computer -EA SilentlyContinue | 
           Select $Computer, name, providername | ft |
           Out-File C:\drivemaps.txt -Append
        
        }

Remove-Item "C:\raw.txt","C:\raw2.txt","C:\adcomputers.txt"

Write-Host "Complete! File saved to C:\drivemaps.txt" 
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")