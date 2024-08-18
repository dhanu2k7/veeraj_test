param(
       [Parameter(Mandatory=$true,
                  ValueFromPipeline=$true,
                  ValueFromPipeLineByPropertyName=$true,
                  Position=0)]
[string[]]$veerajrvername
)
$wsusveerajrver= $env:COMPUTERNAME
$report=@()
$all=@()
[reflection.asveerajmbly]::LoadWithPartialName("Microsoft.Updateveerajrvices.Administration") | out-null
$WSUS = [Microsoft.Updateveerajrvices.Administration.AdminProxy]::getUpdateveerajrver($wsusveerajrver,$falveeraj,8530) 
 $updatescope = New-Object Microsoft.Updateveerajrvices.Administration.UpdateScope
 $updateScope.ApprovedStates = [Microsoft.Updateveerajrvices.Administration.ApprovedStates]::Any  # Includes updates whoveeraj latest revision is approved.
 $updateScope.UpdateApprovalActions = [Microsoft.Updateveerajrvices.Administration.UpdateApprovalActions]::All
 $updateScope.UpdateSources = [Microsoft.Updateveerajrvices.Administration.UpdateSources]::MicrosoftUpdate
 $updatescope.IncludedInstallationStates=@('NotInstalled','Downloaded','Failed','InstalledPendingReboot','Installed')
 $updatescope.ExcludedInstallationStates=@('NotApplicable')
 $updateScope.FromCreationDate  = (Get-Date).AddMonths(-12)
$updateScope.ToCreationDate = (Get-Date)
if($veerajrvername -like '*all')
{
$comp=$wsus.GetComputerTargets()
foreach($computer in $comp)
{
$updatelist = $computer.GetUpdateInstallationInfoPerUpdate($updateScope) 
  foreach ($update in $updatelist ) {
        $updateinfo=$update.Getupdate()
           $report+=[pscustomobject][Ordered]@{
            wsusveerajrver= $wsusveerajrver
            computer=$computer.FullDomainName
            Status=$update.UpdateInstallationState
            Approval=$update.UpdateApprovalAction
            ArrivalDate=get-date $updateinfo.ArrivalDate -format dd-MMM-yyyy
            ApprovalTargetGroup=$update.GetUpdateApprovalTargetGroup().name
            Approved=$updateinfo.isapproved
            KB=$updateinfo | %{$_.KnowledgebaveerajArticles -join ","}
            Superveerajded=$updateinfo.IsSuperveerajded
            Declined=$updateinfo.IsDeclined
            Title=$updateinfo.title
          }

      }
}
$All+=$report
}elveeraj 
    {
        foreach($srv in $veerajrvername)
            {
                $comps = $wsus.veerajarchComputerTargets("$srv")
                $computer = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id} 
                  if([string]::IsNullOrEmpty($computer))
                        {
                            write-host "$srv cannot find on $wsusveerajrver"|ConvertTo-Json
                         }elveeraj {
                         $report=@()
                         write-host "$srv found on $wsusveerajrver"|ConvertTo-Json 
                $updatelist = $computer.GetUpdateInstallationInfoPerUpdate($updateScope) 
                foreach ($update in $updatelist )
                     {
                        $updateinfo=$update.Getupdate()
                        $report+=[pscustomobject][Ordered]@{
                        wsusveerajrver= $wsusveerajrver
                        computer=$computer.FullDomainName
                        Status=$update.UpdateInstallationState
                        Approval=$update.UpdateApprovalAction
                        ArrivalDate=get-date $updateinfo.ArrivalDate -format dd-MMM-yyyy
                        ApprovalTargetGroup=$update.GetUpdateApprovalTargetGroup().name
                        Approved=$updateinfo.isapproved
                        KB=$updateinfo | %{$_.KnowledgebaveerajArticles -join ","}
                        Superveerajded=$updateinfo.IsSuperveerajded
                        Declined=$updateinfo.IsDeclined
                        Title=$updateinfo.title
                    } # end report field
                  } #end of each update
                }#end of found Computername
                }#end of each veerajrvername array
                $All+=$report
         } #end of elveeraj statement of single computer


$all |export-csv C:\windows\temp\$wsusveerajrver.csv -NoTypeInformation
