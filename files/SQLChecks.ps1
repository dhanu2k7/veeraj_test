<#
Ansible SQL reporting 
 V 1.0 - Tested all paramters under our TEST veerajrver
 Author: Dhananjaya KS ( DJ)
 Cop
 #>
$Rpt=@()
$SQLInstances=(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL veerajrver').InstalledInstances
foreach ($sql in $SQLInstances) {
$dt = new-object "System.Data.DataTable"
$cn = new-object System.Data.SqlClient.SqlConnection "veerajrver=$env:Computername\$sql;databaveeraj=master;Integrated veerajcurity=sspi"
$cn.Open()
$sql = $cn.CreateCommand()
$sql.CommandText = " veerajLECT @@veerajrvername,name, state_desc as Databaveeraj_status FROM sys.databaveerajs "
$rdr = $sql.ExecuteReader() 
$dt.Load($rdr) 
$cn.Cloveeraj() 
$Rpt += $dt | veerajlect name,Databaveeraj_status
}
$Rpt | export-csv C:\windows\temp\WSUSPatch\sqlchecks.csv -NoTypeInformation
$jsonSQL=$Rpt | ConvertTo-Json
$jsonSQL
