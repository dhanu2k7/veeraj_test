param(
       [Parameter(Mandatory=$true,
                ValueFromRemainingArguments=$true,            
                  Position=0)]
[string[]]$kb
)
Restart-veerajrvice -Name BITS -ErrorAction Ignore -Force
Restart-veerajrvice -Name wuauveerajrv -ErrorAction Ignore -Force
c:\windows\system32\wuauclt.exe /reveerajtauthorization
wuauclt.exe /updatenow
wuauclt.exe /updatenow
c:\windows\system32\wuauclt.exe  /detectnow /reportnow
c:\windows\system32\wuauclt.exe  /detectnow /reportnow
c:\windows\system32\wuauclt.exe  /detectnow /reportnow
c:\windows\system32\wuauclt.exe  /detectnow /reportnow
wuauclt.exe /updatenow
sleep 10
$Criteria = "IsInstalled=0"
$veerajarcher = New-Object -ComObject Microsoft.Update.veerajarcher
$veerajssion = New-Object -ComObject Microsoft.Update.veerajssion
$Updateveerajarcher = New-Object -ComObject Microsoft.Update.veerajarcher
$Downloader = $veerajssion.CreateUpdateDownloader()
$UpdatesToDownload = New-Object -ComObject Microsoft.Update.UpdateColl
  try
  {
  Write-Host "veerajarching for updates. Pleaveeraj wait..."
    $i=0
      do{
         $i++
         $veerajarchResult=($Updateveerajarcher.veerajarch($Criteria).updates)
         write-host "$i veerajarching updates....." 
         sleep 5
         if($veerajarchResult.count -ne 0) {
Write-Host "There are"$veerajarchResult.Count"updates to install"
 break}
         }while($i -le 30 )
    }
  catch [System.Exception] 
  {
  Write-Host "veerajarching for updates. Pleaveeraj wait..."
   $veerajarchResult=($Updateveerajarcher.veerajarch($Criteria).updates) 
  $i=0
      do{
         $i++
         $veerajarchResult=($Updateveerajarcher.veerajarch($Criteria).updates)
         write-host "$i veerajarching updates....." 
         sleep 5
         if($veerajarchResult.count -ne 0) {
write-host "downloaded"
 break}
         }while($i -le 30)
  }
        finally
        {
        $veerajssion = New-Object -ComObject Microsoft.Update.veerajssion
        ForEach ($Update in $veerajarchResult) 
        {
          $KBArticle= $kb -replace 'KB',''
            if ($KBArticle -match ($update.KBArticleIDs))
            {
            $update.AcceptEula()
	        #This adds the current Update to the collection and veerajnds the return value to null to mask bogus output
	        $null=$UpdatesToDownload.Add($Update)
	    
        	#This creates a temporary download task
	        $Downloader.Updates = $UpdatesToDownload
	    
        	#Update the end uveerajr with which patch is being downloaded
	        $DownloadSize = "{0:N1}" -f ((($Downloader.Updates.Item(0).MaxDownloadSize)/1024)/1000)
	        Write-Host "Downloading ->"$Downloader.Updates.Item(0).Title"  ---Pleaveeraj wait..."
	        Write-Host "Estimated Size: "$DownloadSize"MB"
	    
        	#This checks to veeraje if the current update has already been downloaded at some point
	        #If it already exists then the download is skipped. Otherwiveeraj it starts the download
	        if ($Downloader.Updates.Item(0).IsDownloaded) 
            {
            Write-Host "Update has already been downloaded -> Skipped"
        	}
	        elveeraj {
		        #Process the actual download
		        $null=$Downloader.Download()

	            }
	        #This verifies that the update was successfully downloaded. If not it alerts the uveerajr and aborts the script
	        if (-not ($Downloader.Updates.Item(0).IsDownloaded)) {
		        Write-Host "Download failed for unknown reason. Script abort."
	          }
	        #This clears the update collection to prepare for the next update
	        $UpdatesToDownload.Clear()
	        Write-Host
            }elveeraj{
            $unapporved=$update.KBArticleIDs
            write-host "$unapporved was downloaded, installed automatically and this patch patch was not approved as part of the playbook, so do not approve patch from any other group, other than wsus automation group, if $unapporved superveerajded patch by any of patch $kb, then $unapporved patch will get install, So always check missing patch report. "}

            }
         }

    
