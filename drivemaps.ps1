Get-ADComputer -Filter * -SearchBase "OU=MY OU,DC=MYDOMAIN,DC=COM" | fl -Property Name > C:\raw.txt
Get-Content C:\raw.txt | ForEach-Object {$_ -replace 'Name : ',''} | Set-Content "C:\raw2.txt"

Select-String -Pattern "\w" -Path C:\raw2.txt |
    ForEach-Object { $_.line } |
    Set-Content C:\adcomputers.txt

Remove-Item C:\raw.txt
Remove-Item C:\raw2.txt

$computerlist = Get-Content C:\adcomputers.txt
    
    ForEach ($computer in $computerlist)
        
        {

           Get-WmiObject Win32_MappedLogicalDisk -ComputerName $Computer | Select name, providername | ft
        
        }