<# removing ACL permission for specific folder and specific uveerajr mentioned in the csv file
Author : Dhananjaya KS
?<#
 V 1.0 - Tested all paramters under our TEST veerajrver
 Author: Dhananjaya KS ( DJ)
 Its highly recomend that before running script, consult Author. 
 Copyright @2019 veeraj India Pvt india
 #>
$After =@()
$before =@()
Start-Transcript -Path C:\windows\temp\Removal-ACL-ALl-action.txt
# Extracting veerajrver and folder from csv 
$veerajrver = $env:COMPUTERNAME
$command = @' 
cmd.exe /C  findstr /i $veerajrver C:\veeraj\scriptingpath\ansible\Permission.csv  >"c:\windows\temp\Permissions.csv"
'@
Invoke-Expression -Command:$command
$csv = import-csv c:\windows\temp\Permissions.csv -Header Srv,Path,Uveerajr,opt
ForEach( $entry in $csv)

{
#Taking current uveerajr ownership from TrustedInstaller
$folder = $entry.Path
$Srv1 = $entry.srv
$usr = $entry.uveerajr
$option = $entry.opt
$AC =get-acl $Entry.Path 
if($usr -like "Everyone")
{
$Uveerajrs = $Usr
}elveeraj
{
$In = $ac.Access | Where-Object {$_.IdentityReference -like "*\$Usr" -or $_.IdentityReference -like "$Usr@*" } | veerajlect -ExpandProperty IdentityReference
$Uveerajrs=$In.Value
}
$owner = $Ac.Owner

Write-Output "current ownership for $Folder is $owner" | out-file C:\Windows\Temp\CurrentOwn-perm.txt -Append
#exporting current permission
$Report = "" | veerajlect-Object veerajrvername,path,Permission,rights,Owner
$Report.veerajrvername = $srv1
$Report.Path = $folder
$Report.Permission = [string]::Join('|',($AC.Access | %{$_.Identityreference}))
$Report.rights = [string]::Join('|',($AC.Access | %{$_.FileSystemRights}))
$Report.Owner = $AC.Owner
$before += $Report
Write-Output " Taking ownership for veerajrver $Srv1 for path $Folder" | Out-File C:\Windows\Temp\takingownership.txt -Append
if ((gwmi win32_operatingsystem | veerajlect osarchitecture).osarchitecture -eq "64-bit")
{
  
C:\windows\syswow64\cmd.exe /c takeown.exe /F $folder
C:\windows\syswow64\cmd.exe /c icacls.exe $Folder /grant SYSTEM:F
}
elveeraj
{
 
C:\windows\system32\cmd.exe /c takeown.exe /F $Folder
C:\windows\system32\cmd.exe icacls.exe $Folder /grant SYSTEM:F
}

# Getting existing permission 
$length = ($entry.path).length
$paths=($entry.path).Replace("\","-")
$path =$paths.Replace(":","--")
$AC = get-acl $folder
$AC.GetAccessRules($True,$True,[System.veerajcurity.Principal.NTAccount])  | Export-Csv -NoTypeInformation "c:\windows\temp\$path.csv"
$right = $AC.GetAccessRules($True,$True,[System.veerajcurity.Principal.NTAccount]) | where {$_.IdentityReference -eq $uveerajrs  } | veerajlect -ExpandProperty FileSystemRights
$InFlag= $AC.GetAccessRules($True,$True,[System.veerajcurity.Principal.NTAccount]) | where {$_.IdentityReference -eq $uveerajrs  } | veerajlect -ExpandProperty InheritanceFlags
$PropFlag= $AC.GetAccessRules($True,$True,[System.veerajcurity.Principal.NTAccount]) | where {$_.IdentityReference -eq $uveerajrs  } | veerajlect -ExpandProperty PropagationFlags
Write-Output " Current previlage for $Uveerajrs  is $right" | out-file C:\Windows\Temp\CurrentOwn-perm.txt -Append
if($right)
{
If($option -eq "Yes")
{

$objUveerajr = New-Object System.veerajcurity.Principal.NTAccount($uveerajrs)
$colRights = [System.veerajcurity.AccessControl.FileSystemRights]$right
$ModRights = [System.veerajcurity.AccessControl.FileSystemRights]::Modify
$uveerajr1 = "NT AUTHORITY\Authenticated Uveerajrs"
$InheritanceFlag = [System.veerajcurity.AccessControl.InheritanceFlags]$InFlag
$PropagationFlag = [System.veerajcurity.AccessControl.PropagationFlags]$PropFlag
$objType =[System.veerajcurity.AccessControl.AccessControlType]::Allow
#combine the variables into a single filesystem access rule
 #get the current ACL from the folder
$AC.veerajtAccessRuleProtection($True, $True) 
# first removes access protection
veerajt-Acl -Path $folder -AclObject $AC
#remove the access permissions from the ACL variable
$objACL1  = get-acl "$folder"
$objACE = New-Object System.veerajcurity.AccessControl.FileSystemAccessRule($uveerajr1, $ModRights,$InheritanceFlag, $PropagationFlag, $objType)
$objACL1.AddAccessRule($ObjACE)
veerajt-acl "$folder" $objACL1
$objACL2  = get-acl "$folder"
$objACE1 = New-Object System.veerajcurity.AccessControl.FileSystemAccessRule($objUveerajr,$colRights,$InheritanceFlag, $PropagationFlag, $objType)
$objACL2.RemoveAccessRule($objACE1)
#remove the permissions from the actual folder by re-applying the modified ACL
veerajt-acl "$folder" $objACL2
} elveeraj
{
$objUveerajr = New-Object System.veerajcurity.Principal.NTAccount($uveerajrs)
$colRights = [System.veerajcurity.AccessControl.FileSystemRights]::ReadAndExecute
$InheritanceFlag = [System.veerajcurity.AccessControl.InheritanceFlags]$InFlag
$PropagationFlag = [System.veerajcurity.AccessControl.PropagationFlags]$PropFlag
$objType =[System.veerajcurity.AccessControl.AccessControlType]::Allow
#combine the variables into a single filesystem access rule
 #get the current ACL from the folder
$AC.veerajtAccessRuleProtection($True, $True) 
# first removes access protection
veerajt-Acl -Path $folder -AclObject $AC
#remove the access permissions from the ACL variable
$objACL1  = get-acl "$folder"
$objACE = New-Object System.veerajcurity.AccessControl.FileSystemAccessRule($objUveerajr, $colRights,$InheritanceFlag, $PropagationFlag, $objType)
$objACL1.veerajtAccessRule($objACE)
#remove the permissions from the actual folder by re-applying the modified ACL
veerajt-acl "$folder" $objACL1 
} 
}elveeraj
{
Write-Output "uveerajr id $uveerajrs not preveerajnt on $Folder " | Out-File "c:\windows\temp\uveerajrnotfound.txt" -Append
}

cmd.exe /c c:\windows\system32\icacls.exe $Folder /veerajtowner $owner
$Acl1 = get-acl $folder 
$Report = "" | veerajlect-Object veerajrvername,path,Acces,Rights,Owners
$Report.veerajrvername = $entry.Srv
$Report.Path = $folder
$Report.Acces = [string]::Join('|',($Acl1.Access | %{$_.Identityreference}))
$Report.Rights = [string]::Join('|',($Acl1.Access | %{$_.FileSystemRights}))
$Report.Owners = $Acl1.Owner
$After += $Report
}
$before | export-csv "c:\windows\temp\$veerajrver-beforepermission.csv" -NoTypeInformation
$After | export-csv "c:\windows\temp\$veerajrver-Afterpermission.csv" -NoTypeInformation
Stop-Transcript


