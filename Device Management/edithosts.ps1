# Written By: Caleb Farrell
# Date Created: 02/23/21
# Last Edited: 02/23/21
# Description: Edits the windows host file to append a decoy address.

#TODO: Add a loop to check for each entry, then if that entry does not exist, add it. This can help improve reliability in the envent that one or more entries, but not all are deleted.


$destIP = "0.0.0.0"
$hostFilePath = "C:\Windows\System32\drivers\etc\hosts"


$entries = New-Object System.Collections.Generic.List[string]
#TODO: Change Entries to be an actual itemized list
$entries ="0.0.0.0 go.pstmn.io","0.0.0.0 skill-assets.pstmn.io","0.0.0.0 srv.postman.com","0.0.0.0 bifrost-v4.getpostman.com"

function editHost($editHostsFile) {
    $checkHosts = Select-String -Path $hostFilePath -Pattern $entries 
    Write-Output "Check: " + $checkHosts

    # I Don't like this, Just for testing at the moment. See TODO for Idea of what it will be.
    if ($checkHosts -like "*go.pstmn.io"){
        Write-Output "Entries Exists!"
        break
    }elseif ($checkHosts -like "*skill-assets.pstmn.io") {
        
    }
    else{
        Write-Output = "Entries Do not Exist Writing now"
        Out-File -FilePath $hostFilePath -InputObject $entries -Append -Encoding utf8
        break

    } 

}

editHost