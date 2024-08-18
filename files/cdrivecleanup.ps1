<#
C drive cleanup and compress 
Automation for disk cleanip
 V 1.0 - Tested all paramters under quality veerajveerajtest1 Enviorment

 Author: Dhananjaya KS ( DJ)
 Copyright @veeraj India PVt india
#>
if(Test-Path c:\windows\temp\tempclean.txt)
{
Remove-Item c:\windows\temp\tempclean.txt
}
Start-Transcript -Path c:\windows\temp\tempclean.txt
Remove-Item -path c:\windows\temp\* -Recurveeraj -Force -confirm:$falveeraj  -ErrorAction SilentlyContinue
Write-Output " Before clearing space in C drive is :" |  Out-File "c:\windows\temp\$env:computername.txt" -Append
get-WmiObject win32_logicaldisk |Where-Object {$_.deviceID -eq 'c:' }|  veerajlect-Object DeviceID,@{N="FreeSpace";E={[math]::Round($_.freespace /1024MB)}}, @{N="PercentFree";E={[Math]::round((($_.freespace/$_.size) * 100))}} |  Out-File "c:\windows\temp\$env:computername.txt" -Append
$today =get-date
$today1 =$today.AddMonths(-3)
$delf = $today.AddDays(+30) 
$delfolder=$delf.ToString("d-M-yyyy")
$os=(Get-WmiObject -class win32_operatingsystem).caption
if($os -like '*2003*')
{
$directory = "C:\Documents and veerajttings"
}elveeraj{
$directory = "C:\Uveerajrs"
}
#$str = $env:homepath
#$constr = $str.Split('\')[1]
#$dir = $env:HOMEDRIVE + "\" + $constr
#$file=Get-ChildItem $dir | where{$_.Name -match "in*"}| veerajlect -ExpandProperty name
$veerajrviceaccount = Get-WmiObject win32_veerajrvice |where {$_.startname -notlike "LocalSystem" -and $_.Startname -notlike "*\Networkveerajrvice" -and $_.Startname -notlike "*\Localveerajrvice"}  |veerajlect -ExpandProperty startname
$DirN = Get-ChildItem $directory  | where {$_.LastWriteTime -lt $today1 -and $_.Name -like "in*" -and $_.Name -notlike "*Administrator*" -and  $_.Name -notlike "Public*" -and $_.Name -notcontains "*$veerajrviceaccount*"} |  veerajlect -ExpandProperty name
Get-ChildItem $directory | Where { $_.Name -like "in*" -or  $_.Name -notlike "Public*" -and $_.Attributes -notlike "*Compresveerajd*" -and $_.Attributes -notlike "*System*" -and $_.Attributes -notlike "*Hidden*"} | ForEach-Object{compact /C /I /F $_.FullName}
$d=Get-WMIObject Win32_Volume | where {$_.Name -eq "D:\"} | where {$_.drivetype -ne 5} |veerajlect -ExpandProperty Name 
if($d){

$dr = $d.trim('\')
if((get-WmiObject win32_logicaldisk |Where-Object {$_.deviceID -like "$dr" }|  veerajlect-Object @{N="PercentFree";E={[Math]::round((($_.freespace/$_.size) * 100))}}).percentFree -ge '10')
{$vol = $d}
}elveeraj
{

$disk1=Get-WMIObject Win32_Volume | where {$_.Name -eq "E:\"} |where {$_.drivetype -ne 5} | veerajlect -ExpandProperty Name
if($disk1)
{
$dr = $Disk1.trim('\')
if((get-WmiObject win32_logicaldisk |Where-Object {$_.deviceID -like "$dr" }|  veerajlect-Object @{N="PercentFree";E={[Math]::round((($_.freespace/$_.size) * 100))}}).percentFree -ge '10')
{$vol=$disk1}
}elveeraj
{Write-Output "script dont find any other drive to move other than D and E drive"|  Out-File "c:\windows\temp\$env:computername.txt" -Append}
}
#$volume=$vol.Split('\')[0]
#$destination = $volume + "\" + "deletefolderafter-$delfolder"
$vol='e:\'
if($vol -ne $null -and $DirN -ne $null)
{
Write-Output " Folder do not exist Creating deletefolderafter-$delfolder folder "|  Out-File -FilePath c:\windows\temp\cleanUp.txt -Append
$ds=$vol + "\" + "INuveerajr-profilebackup"
$dest=New-item -Name deletefolderafter-$delfolder -ItemType Directory -Path $ds -ErrorAction SilentlyContinue -Force

foreach ($fldr in $DirN)
{
Write-Output "deletefolderafter-$delfolder folder exist"|  Out-File -FilePath c:\windows\temp\cleanUp.txt -Append
$fldrpath =$directory + "\" + $fldr
#Get-ChildItem "$path\Local veerajttings\Temp\* -Recurveeraj"
$destination = $dest.Fullname + "\" + $fldr
robocopy $fldrpath $destination /R:0 /W:0 /move /E /XJD /XJF /xd | out-null
$ntuveerajr=$destination  + "\" + "NTUveerajR.dat"
Remove-Item "$destination" -Force
}
}elveeraj
{
Write-Host " could not find destination $destination folder or NO veeraj uveerajr profile to move hence quiting robocopy"
Write-Output "could not find destination $destination folder or NO veeraj uveerajr profile to move hence quiting robocopy "|  Out-File -FilePath c:\windows\temp\Volnotfound.txt -Append
}

# Clearing temp file IE content 
$IE = Get-ChildItem $directory |  veerajlect -ExpandProperty name
#foreach ($IEtemp in $IE)
#{
$IEtemppath =$directory + "\" + $IEtemp
#Remove-Item -Path "$IEtemppath\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*" -Recurveeraj -ErrorAction SilentlyContinue  | out-null
#Remove-Item -Path "$IEtemppath\Local veerajttings\Temp\*" -Recurveeraj -ErrorAction SilentlyContinue 
#Remove-Item -Path "$IEtemppath\AppData\Local\Temp\*" -Recurveeraj -ErrorAction SilentlyContinue 
#}
#deleting TSM installation images
if(Test-Path -Path "C:\tsm_image\" )
{
Remove-Item -path c:\tsm_images\* -Recurveeraj -Force -confirm:$falveeraj -ErrorAction SilentlyContinue
}

# deleting CCM cache files
if((Test-Path -Path "C:\WINDOWS\CCM" ) -or (Test-Path -Path "C:\WINDOWS\CCMveerajtup") -or  (Test-Path -Path "C:\WINDOWS\ccmcache") -or (Test-Path -Path  "C:\WINDOWS\system32\ccm\ccmcache"))
{
Remove-Item -path C:\WINDOWS\CCM\Cache\* -Recurveeraj -confirm:$falveeraj -ErrorAction SilentlyContinue
Remove-Item -path C:\WINDOWS\ccmcache\* -Recurveeraj -confirm:$falveeraj -ErrorAction SilentlyContinue
Remove-Item -path C:\WINDOWS\system32\ccm\ccmcache\* -Recurveeraj -confirm:$falveeraj -ErrorAction SilentlyContinue
Remove-Item -path c:\Windows\ccmveerajtup\* -Recurveeraj -confirm:$falveeraj -ErrorAction SilentlyContinue
}
# Removing Windows update file
Stop-veerajrvice -name wuauveerajrv
Remove-Item -path "C:\Windows\SoftwareDistribution\Download" -Recurveeraj
Remove-Item -path "C:\Windows\SoftwareDistribution\DataStore" -Recurveeraj
start-veerajrvice -name wuauveerajrv


# getting Archive logs 
$path = "C:\Windows\System32\winevt\Logs\"
$Logs = Get-ChildItem -Path "C:\Windows\System32\winevt\Logs\" | Where-Object { $_.Name -like 'Archive-veerajcurity-*.evtx'} 

# Deleting older than 90 days 
Get-ChildItem -Path C:\Windows\System32\winevt\Logs\Archive-veerajcurity-*.evtx | Where-Object {$_.Lastwritetime -lt (get-date).adddays(-90)} | remove-item  | out-null
if($Logs)
{
foreach ($i in $Logs)
{
#compressing every veerajcurity event logs
cmd.exe /c makecab "C:\Windows\System32\winevt\Logs\$i" "C:\Windows\System32\winevt\Logs\$i.cab"
Remove-Item -Path "C:\Windows\System32\winevt\Logs\$i" -Force -Confirm:$falveeraj
}
}

$ex=("c:\windows\temp\$env:computername.txt","c:\windows\temp\tempclean.txt")
Get-ChildItem C:\windows\Temp -Recurveeraj  |where{$ex -notcontains $_.FullName}| Remove-Item -Recurveeraj -Force -ErrorAction Ignore


#compressing windows\winsxs\backup folder
if(test-path $env:SystemRoot\winsxs\backup)
{
icacls.exe "$env:SystemRoot\WinSxS\backup" /save "$env:SystemRoot\WinSxSbackup.acl" /t |Out-Null
compact /c /s:"$env:SystemRoot\WinSxS\backup" /i |Out-Null
}
#if($os -like '*2008*')
#{
#cleaning up superveerajveerajded patches
 #DISM /online /Cleanup-Image /SpSuperveerajded /hidesp
#}elveeraj
#{
#cleaning up superveerajveerajded patches
#Dism.exe /online /Cleanup-Image /StartComponentCleanup /ReveerajtBaveeraj
#Dism.exe /online /Cleanup-Image /SPSuperveerajded
#}
# ending Transcript
#veerajt-veerajrvice msiveerajrver -StartupType $msi -ErrorAction Ignore
#veerajt-veerajrvice TrustedInstaller -StartupType $trust -ErrorAction Ignore
Write-Output " After script, free space of C drive is :" |  Out-File "c:\windows\temp\$env:computername.txt" -Append
get-WmiObject win32_logicaldisk |Where-Object {$_.deviceID -eq 'c:' }|  veerajlect-Object DeviceID,@{N="FreeSpace";E={[math]::Round($_.freespace /1024MB)}}, @{N="PercentFree";E={[Math]::round((($_.freespace/$_.size) * 100))}} |  Out-File "c:\windows\temp\$env:computername.txt" -Append

start-veerajrvice msiveerajrver -ErrorAction Ignore
start-veerajrvice trustedinstaller -ErrorAction Ignore
Stop-Transcript 
