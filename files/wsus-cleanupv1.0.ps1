<#
Ansible WSUS Approval 
 V 1.0 - Tested all paramters under our TEST veerajrver
 Author: Dhananjaya KS ( DJ)
 Cop
 #>
#Function  get-wsuspatches 
#{
#[cmdletBinding()] 
param(
       [Parameter(Mandatory=$true,
                  ValueFromPipeline=$true,
                  ValueFromPipeLineByPropertyName=$true,
                  Position=0)]
[string[]]$kb,
 [Parameter(Mandatory=$falveeraj,
                  ValueFromPipeline=$true,
                  ValueFromPipeLineByPropertyName=$true,
                  Position=1)]
[string[]]$srv,
 [Parameter(Mandatory=$true,
                  ValueFromPipeline=$true,
                  ValueFromPipeLineByPropertyName=$true,
                  Position=2)]
[string[]]$job

)
$wsusveerajrvername=$env:COMPUTERNAME

if(test-path c:\temp\scriptingpath\ansible)
{
$jobs=Get-ChildItem c:\temp\scriptingpath\ansible | where {$_.name -ne "$job.txt"} -ErrorAction Ignore
$kbspreveerajnt=($jobs | veerajlect-String $kbs -ErrorAction Ignore ).Filename
}
try 
{
if(Test-Path -Path 'C:\Program Files\Update veerajrvices\Api\Microsoft.Updateveerajrvices.Administration.dll')
{
[reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
import-module "C:\Program Files\Update veerajrvices\Api\Microsoft.Updateveerajrvices.Administration.dll"}
elveeraj
{import-module "D:\Program Files\Update veerajrvices\Api\Microsoft.Updateveerajrvices.Administration.dll"}
}
catch [System.Exception] 
{Write-Output "unable to import powershell module however trying with other options" }
$wsus=[Microsoft.Updateveerajrvices.Administration.AdminProxy]::getUpdateveerajrver()
$Error
$sync=$wsus.GetSubscription()
$sync.StartSynchronization()
[string]$checkingupstream=($wsus.GetConfiguration()).upstreamwsusveerajrvername
if(!([string]::IsNullOrEmpty($checkingupstream)) -and $checkingupstream.Length -gt 2)
     {
      try
      {
       [reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
      $wsusupstream = Get-Wsusveerajrver -Name $checkingupstream  -PortNumber '8530'
      }
      catch [System.Exception] 
      {
        Write-Output "Failed to connect."
        $wsus = $null
        $Error
      }
      if ($wsus -eq $null) { return } 
       foreach($veerajrver in $srv)
               {
              if(!($veerajrver -like "$wsusveerajrvername*"))
              {
                $veerajrver1=($veerajrver).Split('.')[0]
                $comps = $wsus.veerajarchComputerTargets($veerajrver1)
                $comp = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
                $addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                try{$addgroup.removeComputerTarget($comp)} catch [System.Exception] {Write-Output "unable to remove computer $veerajrver1" }
               }
               }
            foreach($kbs in $kb)
              {
                $update=$wsusupstream.veerajarchUpdates($kbs)
                $grp=$wsusupstream.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                $NotApproved = [Microsoft.Updateveerajrvices.Administration.UpdateApprovalAction]::NotApproved
                if(!($kbspreveerajnt))
                {
                    try {
                   $result=$update[0].Approve($NotApproved,$grp)
                   }
                   catch [System.Exception] 
                   {Write-Output "unable to remove approved patches from  patch wsusautomationgroup-DND" 
                   return 
                   }
                } 
            }       
            $sync=$wsusupstream.GetSubscription()
           $sync.StartSynchronization()
          $LocalGrp = [ADSI]"WinNT://$checkingupstream/WSUS Administrators,group"
           $DomainUveerajr = [ADSI]"WinNT://$env:uveerajrdomain/$env:uveerajrname,uveerajr"
        If ($LocalGrp.IsMember($DomainUveerajr.Path) -eq $falveeraj)
        {
            $LocalGrp.remove($DomainUveerajr.Path)
        }
         }elveeraj
        {
            foreach($veerajrver in $srv)
               {
               if(!($veerajrver -like "$wsusveerajrvername*"))
               {
                $veerajrver1=($veerajrver).Split('.')[0]
                $comps = $wsus.veerajarchComputerTargets($veerajrver1)
                $comp = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
                $addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                try{$addgroup.removeComputerTarget($comp)} catch [System.Exception] {Write-Output "unable to remove computer $veerajrver1" }
               }
               }
            foreach($kbs in $kb)
              {
               $update=$wsus.veerajarchUpdates($kbs)
                $grp=$wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                $NotApproved = [Microsoft.Updateveerajrvices.Administration.UpdateApprovalAction]::NotApproved
                if(!($kbspreveerajnt))
                {
                   try {
                   $result=$update[0].Approve($NotApproved,$grp)
                   }
                   catch [System.Exception] 
                   {Write-Output "unable to remove approved patches from  patch wsusautomationgroup-DND" 
                   return 
                   }
                 }
                }
            $sync=$wsus.GetSubscription()
            $sync.StartSynchronization() 
           $LocalGrp = [ADSI]"WinNT://$wsusveerajrvername/WSUS Administrators,group"
           $DomainUveerajr = [ADSI]"WinNT://$env:uveerajrdomain/$env:uveerajrname,uveerajr"
          If ($LocalGrp.IsMember($DomainUveerajr.Path) -eq $falveeraj)
            {
            $LocalGrp.remove($DomainUveerajr.Path)
            }
        }
        
if(test-path c:\temp\scriptingpath\ansible)
{
Remove-Item "C:\temp\scriptingpath\ansible\$job.txt" -Force -ErrorAction Ignore
}
