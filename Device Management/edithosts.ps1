# Written By: Caleb Farrell
# Date Created: 02/23/21
# Last Edited: 02/23/21
# Description: Edits the windows host file to append a decoy address.

#TODO: Add a loop to check for each entry, then if that entry does not exist, add it. This can help improve reliability in the envent that one or more entries, but not all are deleted.


$destIP = "0.0.0.0"
$hostFilePath = "C:\Windows\System32\drivers\etc\hosts"

$totalEntries = 4
$entries = New-Object System.Collections.Generic.List[string]
#TODO: Change Entries to be an actual itemized list
$entries ="0.0.0.0 go.pstmn.io","0.0.0.0 skill-assets.pstmn.io","0.0.0.0 srv.postman.com","0.0.0.0 bifrost-v4.getpostman.com"


function editHost($editHostsFile) {
    foreach ($item in $entries) {
        #for each item in the list of entries, check for the item in the hosts file, if item does not exist add item, else move to next item until all items have been added.
        $itemChecker = Select-String -Path $hostFilePath -Pattern $item -Quiet
    
        if ($itemChecker -like "True"){
            Write-Output "Exists!"
    
        }elseif ($itemChecker -like "False"){
            Write-Warning "Does not exist"
            Write-Output "Appending entry: $item to hosts File"
            try {
                Out-File -FilePath $hostFilePath -InputObject $item -Append -Encoding utf8
            }
            catch {
                Write-Error "$computer Get-WMIObject : Access is denied. (Exception from HRESULT: 0x80070005 
                (E_ACCESSDENIED))"
                Write-Warning "Please Run as Administrator!"
            }
        }
    }
    
}

editHost