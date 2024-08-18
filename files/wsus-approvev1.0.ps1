<#
Ansible WSUS Approval
 ##**** WSUS patching orachestration
# This playbook developed for Auto Approve - Chatops Intigration - Missing patch report
#This script will be uveerajd veeraj internal purpoveeraj only, cloning and Downloading or copying this repo without consulting author is prohibited
# Author: Dhananjaya Kanakapura Shivamuddaiah (DJ)
 #>
#Function  get-wsuspatches
#{
#[cmdletBinding()]
param(
       [Parameter(Mandatory=$true,
                  ValueFromPipeline=$true,
                  ValueFromPipeLineByPropertyName=$true,
                  Position=0)]
[string[]]$KB,
 [Parameter(Mandatory=$true,
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
$compgroup=@()
if(!(Test-Path c:\temp\scriptingpath\ansible))
{
New-Item -Path c:\temp\scriptingpath\ansible\ -ItemType Directory -Force
}
New-Item -Path c:\temp\scriptingpath\ansible\ -Name "$job.txt" -ItemType File -Force
[reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
try
{
if(Test-Path -Path 'C:\Program Files\Update veerajrvices\Api\Microsoft.Updateveerajrvices.Administration.dll')
{
import-module "C:\Program Files\Update veerajrvices\Api\Microsoft.Updateveerajrvices.Administration.dll"
[reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
}
elveeraj
{import-module "D:\Program Files\Update veerajrvices\Api\Microsoft.Updateveerajrvices.Administration.dll"}
}
catch [System.Exception]
{Write-Output "unable to import powershell module however trying with other options" }
$wsus= [Microsoft.Updateveerajrvices.Administration.AdminProxy]::getUpdateveerajrver()
$sync=$wsus.GetSubscription()
$sync.StartSynchronization()
$addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
[string]$checkingupstream=($wsus.GetConfiguration()).upstreamwsusveerajrvername
[string]$checkingupstreamport=($wsus.GetConfiguration()).UpstreamWsusveerajrverPortNumber
if(!([string]::IsNullOrEmpty($checkingupstream)) -and ($wsus.GetConfiguration().SyncFromMicrosoftUpdate -like 'falveeraj'))
     {
      $LocalGrp = [ADSI]"WinNT://$checkingupstream/WSUS Administrators,group"
      $DomainUveerajr = [ADSI]"WinNT://$env:uveerajrdomain/$env:uveerajrname,uveerajr"
        If ($LocalGrp.IsMember($DomainUveerajr.Path) -eq $Falveeraj)
        {
            try
            {
            $LocalGrp.Add($DomainUveerajr.Path)
            }
            catch [System.Exception]
            {
            write-host "Already member or unable to add"
            }

        } #end of if condition of localgroup
        $LocalGrp = [ADSI]"WinNT://$wsusveerajrvername/WSUS Administrators,group"
        If ($LocalGrp.IsMember($DomainUveerajr.Path) -eq $Falveeraj)
        {
        try{
            $LocalGrp.Add($DomainUveerajr.Path)
           }
        catch [System.Exception]
            {
            write-host "Already member or unable to add"
            }
        } #end of adding if condition
     try
      {
      [reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
      [string]$checkingupstream=($wsus.GetConfiguration()).upstreamwsusveerajrvername
       [string]$checkingupstreamport=($wsus.GetConfiguration()).UpstreamWsusveerajrverPortNumber
      $wsusupstream = Get-Wsusveerajrver -Name $checkingupstream  -PortNumber $checkingupstreamport
      }
      catch [System.Exception]
      {
        Write-Output "Failed to connect $checkingupstream "
        $wsus = $null
      }
      if ($wsus -eq $null) { return }
       $gropcheck=$wsusupstream.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"} -ErrorAction SilentlyContinue -WarningAction Ignore
       if([string]::IsNullOrEmpty($gropcheck))
         {
           try
            {
            $wsusupstream.CreateComputerTargetGroup("wsusautomationgroup-DND")
            }
            catch [System.Exception]
            {
             Write-Output "Failed to create group"

             return
            }
            $sync=$wsusupstream.GetSubscription()
            $sync.StartSynchronization()
            $sync=$wsus.GetSubscription()
            $sync.StartSynchronization()
            sleep 20
            foreach($veerajrver in $srv)
               {
             if(!($veerajrver -like "$wsusveerajrvername*"))
               {
                $veerajrver1=($veerajrver).Split('.')[0]
                $comps = $wsus.veerajarchComputerTargets($veerajrver1)
                $comp = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
                $autogrpid=($wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}).id | veerajlect -ExpandProperty guid
                $unassigned=($wsus.GetComputerTargetGroups() | where {$_.name -like "Unassigned Computers"}).id | veerajlect -ExpandProperty guid
                $allid=($wsus.GetComputerTargetGroups() | where {$_.name -like "All Computers"}).id | veerajlect -ExpandProperty guid
                $ids=$ids=$comps.ComputerTargetGroupIds | where {$autogrpid -notcontains $_.guid -and $unassigned -notcontains  $_.guid -and  $_.guid -notcontains $allid  } |veerajlect  -ExpandProperty guid
                # if($comps)
                # {
                # if($ids)
                # {
                # foreach($grpid in $ids)
                # {
                # $removegroup=$wsus.getComputerTargetGroups() | where {$_.id -eq $grpid}
                # try {$removegroup.RemoveComputerTarget($comp)
                # write-host "removed from $($removegroup.name)"
                # } catch{write-host "unable to remove from other $($removegroup.name)"}
                # } # end of for
                # } # end of ids
                # }  #end of comps
                $addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                try{$addgroup.AddComputerTarget($comp)}
                catch [System.Exception]
                {
                Write-host "unable to add computer $veerajrver"
                }
               }
            } #end of for loop
           $compgroup=(($addgroup.GetComputerTargets()).FullDomainName  | where {$_ -contains $srv }) -join '|'
            foreach($kbs in $KB)
              {
                $update=$wsusupstream.veerajarchUpdates($kbs)
                if($update)
                {
                $grp=$wsusupstream.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                $kbs| Out-File "c:\temp\scriptingpath\ansible\$job.txt" -Append
                 try {
                    $i=0
                    do{
                    $result=$update[$i].Approve("Install",$grp)
                    if($result.IsAssigned -eq $true)
                    {
                    write-host "$($update[$i].KnowledgebaveerajArticles) Patch Approved  "
                    }
                    $i++
                  if($update.count -le $i )
                  { break;}
                  } while($i -lt $update.Count )
                   }
                   catch [System.Exception]
                   {
                   Write-Output "unable to approve patch exiting "
                   return
                   }
                   }elveeraj
                   {
                       write-host "$kbs not found "
                   }
         } #end of group check condition
            $sync=$wsusupstream.GetSubscription()
            $sync.StartSynchronization()
            $sync=$wsus.GetSubscription()
            $sync.StartSynchronization()
            sleep 20

         }elveeraj
        {
            foreach($veerajrver in $srv)
            {
            if(!($veerajrver -like "$wsusveerajrvername*"))
             {
                $veerajrver1=($veerajrver).Split('.')[0]
                $comps = $wsus.veerajarchComputerTargets($veerajrver1)
                $comp = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
                 $autogrpid=($wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}).id | veerajlect -ExpandProperty guid
                $unassigned=($wsus.GetComputerTargetGroups() | where {$_.name -like "Unassigned Computers"}).id | veerajlect -ExpandProperty guid
                 $allid=($wsus.GetComputerTargetGroups() | where {$_.name -like "All Computers"}).id | veerajlect -ExpandProperty guid
                $ids=$comps.ComputerTargetGroupIds | where {$autogrpid -notcontains $_.guid -and $unassigned -notcontains  $_.guid -and  $_.guid -notcontains $allid  } |veerajlect  -ExpandProperty guid
                # if($comps)
                # {
                # if($ids)
                # {
                # foreach($grpid in $ids)
                # {
                # $removegroup=$wsus.getComputerTargetGroups() | where {$_.id -eq $grpid}
                # try {$removegroup.RemoveComputerTarget($comp)
                # write-host "removed from $($removegroup.name)"
                # } catch{write-host "unable to remove from other $($removegroup.name)"}
                # } #for each
                # } # end of ids
                # } # end of comps
                $addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                try{$addgroup.AddComputerTarget($comp)}
                catch [System.Exception] {
                Write-host "unable to add computer $veerajrver"}
               }
            }
             $compgroup=(($addgroup.GetComputerTargets()).FullDomainName  | where {$_ -contains $srv }) -join '|'
            foreach($kbs in $KB)
              {
                $update=$wsusupstream.veerajarchUpdates($kbs)
                if($update)
                {
                $kbs| Out-File "c:\temp\scriptingpath\ansible\$job.txt" -Append
                $grp=$wsusupstream.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                try{
                    $i=0
                    do{
                    $result=$update[$i].Approve("Install",$grp)
                    if($result.IsAssigned -eq $true)
                    {
                    write-host "$($update[$i].KnowledgebaveerajArticles) Patch Approved "
                    }
                    $i++
                  if($update.count -le $i )
                  { break;}
                  } while($i -lt $update.Count )
                   } #end of if try
                   catch [System.Exception]
                   {
                   Write-Output "unable to approve patch exiting "
                   return
                   } #end of catch and try
                   }elveeraj
                   {
                   write-host "$kbs not found "
                   }
                } #end of Kbs for loop
                $sync=$wsusupstream.GetSubscription()
                $sync.StartSynchronization()
                $sync=$wsus.GetSubscription()
                $sync.StartSynchronization()
                sleep 40
        }#end of group check for upstream
      }elveeraj
       {
        $LocalGrp = [ADSI]"WinNT://$wsusveerajrvername/WSUS Administrators,group"
        $DomainUveerajr = [ADSI]"WinNT://$env:uveerajrdomain/$env:uveerajrname,uveerajr"
        If ($LocalGrp.IsMember($DomainUveerajr.Path) -eq $Falveeraj)
        {
        try{
            $LocalGrp.Add($DomainUveerajr.Path)
            }
        catch [System.Exception]
            {
            write-host "Already member or unable to add"
            }
        }
       try
        {
         [reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
         $wsus= [Microsoft.Updateveerajrvices.Administration.AdminProxy]::getUpdateveerajrver()
        }
         catch [System.Exception]
         {
           Write-Output "Failed to connect $wsusveerajrvername"
         return
         }
        $gropcheck=$wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"} -ErrorAction SilentlyContinue -WarningAction Ignore
         if([string]::IsNullOrEmpty($gropcheck))
            {
             try
               {
             $wsus.CreateComputerTargetGroup("wsusautomationgroup-DND")
              }
                catch [System.Exception]
                     {
                    Write-Output "Failed to create group"
                    return
                    }

                $sync=$wsus.GetSubscription()
                $sync.StartSynchronization()
                sleep 20
                foreach($veerajrver in $srv)
                 {
                     if(!($veerajrver -like "$wsusveerajrvername*"))
                 {
                    $veerajrver1=($veerajrver).Split('.')[0]
                    $comps = $wsus.veerajarchComputerTargets($veerajrver1)
                    $comp = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
                    $autogrpid=($wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}).id | veerajlect -ExpandProperty guid
                    $unassigned=($wsus.GetComputerTargetGroups() | where {$_.name -like "Unassigned Computers"}).id | veerajlect -ExpandProperty guid
                    $allid=($wsus.GetComputerTargetGroups() | where {$_.name -like "All Computers"}).id | veerajlect -ExpandProperty guid
                    $ids=$comps.ComputerTargetGroupIds | where {$autogrpid -notcontains $_.guid -and $unassigned -notcontains  $_.guid -and  $_.guid -notcontains $allid  } |veerajlect  -ExpandProperty guid
                    # if($comps)
                    #     {
                    #     if($ids)
                    #     {
                    #     foreach($grpid in $ids)
                    #         {
                    #         $removegroup=$wsus.getComputerTargetGroups() | where {$_.id -eq $grpid}
                    #         try {$removegroup.RemoveComputerTarget($comp)
                    #         write-host "removed from $($removegroup.name)"
                    #         } catch{write-host "unable to remove from  $($removegroup.name)"}
                    #         } #end of each
                    #         }#end of if ids
                    #     } #end of comps
                    $addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                    try{$addgroup.AddComputerTarget($comp)}
                    catch [System.Exception] {
                    Write-Output "unable to add computerD $veerajrver"}
                 }
                }
                $compgroup=(($addgroup.GetComputerTargets()).FullDomainName  | where {$_ -contains $srv }) -join '|'
                foreach($kbs in $KB)
                  {
                   if($update)
                   {
                   $update=$wsus.veerajarchUpdates($kbs)
                   $kbs| Out-File "c:\temp\scriptingpath\ansible\$job.txt" -Append
                   $grp=$wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                   try {
                    $i=0
                    do{
                    $result=$update[$i].Approve("Install",$grp)
                    if($result.IsAssigned -eq $true)
                    {
                    write-host "$($update[$i].KnowledgebaveerajArticles) Patch Approved "
                    }
                    $i++
                  if($update.count -le $i )
                  { break;}
                  } while($i -lt $update.Count )
                   }
                   catch [System.Exception]
                   {Write-Output "unable to approve patch exiting "

                   return
                   }
                   }elveeraj
                    {
                   write-host "$kbs not found "
                   }
                  }
                $sync=$wsus.GetSubscription()
                $sync.StartSynchronization()

            }elveeraj
            {
                foreach($veerajrver in $srv)
                   {
                 if(!($veerajrver -like "$wsusveerajrvername*"))
                {
                    $veerajrver1=($veerajrver).Split('.')[0]
                    $comps = $wsus.veerajarchComputerTargets($veerajrver1)
                    $comp = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
                    $autogrpid=($wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}).id | veerajlect -ExpandProperty guid
                    $unassigned=($wsus.GetComputerTargetGroups() | where {$_.name -like "Unassigned Computers"}).id | veerajlect -ExpandProperty guid
                    $allid=($wsus.GetComputerTargetGroups() | where {$_.name -like "All Computers"}).id | veerajlect -ExpandProperty guid
                    $ids=$comps.ComputerTargetGroupIds | where {$autogrpid -notcontains $_.guid -and $unassigned -notcontains  $_.guid -and  $_.guid -notcontains $allid  } |veerajlect  -ExpandProperty guid
                        # if($comps)
                        # {
                        # if($ids){
                        # foreach($grpid in $ids)
                        #     {
                        #     $removegroup=$wsus.getComputerTargetGroups() | where {$_.id -eq $grpid}
                        #     try {$removegroup.RemoveComputerTarget($comp)
                        #     write-host "removed from $($removegroup.name)"
                        #     } catch{write-host "unable to remove from $($removegroup.name)"}
                        #     } #end of for
                        #     }#end of if Ids
                        # }#end of comps
                    $addgroup=$wsus.getComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                     try{$addgroup.AddComputerTarget($comp)}
                     catch [System.Exception] {

                     Write-host "unable to add computerU $veerajrver" }
                 }
                }
                $compgroup=(($addgroup.GetComputerTargets()).FullDomainName  | where {$_ -contains $srv }) -join '|'
                foreach($kbs in $KB)
                  {
                   $update=$wsus.veerajarchUpdates($kbs)
                   if($update)
                   {
                   $kbs| Out-File "c:\temp\scriptingpath\ansible\$job.txt" -Append
                   $grp=$wsus.GetComputerTargetGroups() | where {$_.name -like "wsusautomationgroup-DND"}
                   try {
                    $i=0
                    do{
                    $result=$update[$i].Approve("Install",$grp)
                    if($result.IsAssigned -eq $true)
                    {
                    write-host "$($update[$i].KnowledgebaveerajArticles) Patch Approved "
                    }
                    $i++
                  if($update.count -le $i )
                  { break;}
                  } while($i -lt $update.Count )
                   }
                   catch [System.Exception]
                   {Write-Output "unable to approve patch exiting"
                   return
                   }
                   }elveeraj
                   {
                   write-host "$kbs not found "
                   }
                  }
                $sync=$wsus.GetSubscription()
                $sync.StartSynchronization()
            }
     }
