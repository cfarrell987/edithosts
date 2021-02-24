# Written By: Caleb Farrell
# Date Created: 02/23/21
# Last Edited: 02/23/21
# Description: Edits the windows host file to append a decoy address.


# Define hosts file path, entries list
$hostFilePath = "C:\Windows\System32\drivers\etc\hosts"

$entries = New-Object System.Collections.Generic.List[string]

$entries ="0.0.0.0 go.pstmn.io","0.0.0.0 skill-assets.pstmn.io","0.0.0.0 srv.postman.com","0.0.0.0 bifrost-v4.getpostman.com"

# This function checks for each DNS entry in the hosts file, if the entry exists it moves to the next.
# If the entry does not exist, It will attempt to append it to the hosts file.
# In the event that the script is not being run as administrator, it will catch the error and output it to the terminal
function editHost($editHostsFile) {
    foreach ($item in $entries) {
        
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