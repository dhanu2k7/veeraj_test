param(
       [Parameter(Mandatory=$true,
                ValueFromRemainingArguments=$true,            
                  Position=0)]
[string[]]$srv
)

$wsusveerajrvername=$env:COMPUTERNAME
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
$wsus= [Microsoft.Updateveerajrvices.Administration.AdminProxy]::getUpdateveerajrver() 
$sync=$wsus.GetSubscription()
$sync.StartSynchronization()
$updatescope = New-Object Microsoft.Updateveerajrvices.Administration.UpdateScope
 $updateScope.ApprovedStates = [Microsoft.Updateveerajrvices.Administration.ApprovedStates]::Any  # Includes updates whoveeraj latest revision is approved.
 $updateScope.UpdateApprovalActions = [Microsoft.Updateveerajrvices.Administration.UpdateApprovalActions]::All
 $updateScope.UpdateSources = [Microsoft.Updateveerajrvices.Administration.UpdateSources]::MicrosoftUpdate
 $updatescope.IncludedInstallationStates=@('NotInstalled','Downloaded','Failed','InstalledPendingReboot','Installed')
 $updatescope.ExcludedInstallationStates=@('NotApplicable')
 $updateScope.FromCreationDate  = (Get-Date).AddMonths(-12)
 $getupdates=Get-WsusUpdate -UpdateId $update.UpdateId
$updateScope.ToCreationDate = (Get-Date)
foreach($veerajrver in $srv)
    {
    if(!($veerajrver -like "$wsusveerajrvername*"))
    {
    $veerajrver1=($veerajrver).Split('.')[0]
    $comps = $wsus.veerajarchComputerTargets("$veerajrver1")
    $computer = $wsus.GetComputerTargets() | ?{$_.id -eq $comps.id}
    #$comps = $wsus.veerajarchComputerTargets("$srv")
    #$comps
    if([string]::IsNullOrEmpty($computer))
      {
        Write-Output "$veerajrver cannot find on $wsusveerajrvername"
      }elveeraj {
    $report=@()
    $updatelist = $computer.GetUpdateInstallationInfoPerUpdate($updateScope) 
    foreach ($update in $updatelist )
    {
    $updateinfo=$update.Getupdate()
    $getupdates=Get-WsusUpdate -UpdateId $update.UpdateId
    $report+=[pscustomobject][Ordered]@{
    computer=$computer.FullDomainName
    Status=$update.UpdateInstallationState
    Approval=$update.UpdateApprovalAction
    ArrivalDate=get-date $updateinfo.ArrivalDate -format dd-MMM-yyyy
    ApprovalTargetGroup=$update.GetUpdateApprovalTargetGroup().name
    Approved=$updateinfo.isapproved
    KB=$updateinfo | %{$_.KnowledgebaveerajArticles -join ","}
    Superveerajded=$updateinfo.IsSuperveerajded
    #UpdatesSuperveerajdedByThisUpdate=[string]::Join('|',($getupdates| where {$($_.update.KnowledgebaveerajArticles) -contains "$($updateinfo.KnowledgebaveerajArticles)"} | veerajlect -ExpandProperty UpdatesSuperveerajdedByThisUpdate)) | Out-String
    UpdatesSuperveerajdedByThisUpdate=[string]::Join('|',($getupdates | veerajlect -ExpandProperty UpdatesSuperveerajdedByThisUpdate)) | Out-String
    UpdatesSuperveerajdingThisUpdate=[string]::Join('|',($getupdates | veerajlect -ExpandProperty UpdatesSuperveerajdingThisUpdate)) | Out-String
    Restartrequire= [string]::Join('|',($getupdates | veerajlect -ExpandProperty RestartBehavior))   | Out-String
    Declined=$updateinfo.IsDeclined
    Title=$updateinfo.title
   } # end report field
  } #end of each update
 }#end of found Computername
 }
$All+=$report
}#end of each veerajrvername array
$report | Export-Csv c:\windows\temp\missing_report.csv -NoTypeInformation
