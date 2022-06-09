function Change-GitSignature {
    <#
    .Synopsis
        Function to easily switch between GPG signatures and emails for git
    .PARAMETER personal
        Switch: Configures git to use your personal GPG key and email to sign commits
    .PARAMETER work
        Switch: Configures git to use your work GPG key and email to sign commits
    .NOTES
        Author: @Halldk (Dustin Hall)
        Uses a CSV file that has the key IDs of your GPG key, with a type either "work" or "personal" used to distinguish them.
        File expected to be in ~\.gnupg\key_ids.csv
        #File format: 
        type, id, email
        work, fakekeyid1, work@email.com
        personal, fakekeyid2, personal@email.com
        #End File format#

        To automatically load module into powershell for your profile, add to "~\Documents\WindowsPowershell\" folder and add to existing profile file. If no profile file exists, use this guide:
        path: ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
        #File contents: 
        Import-Module $Profile\..\change-gitsignature.ps1 
        #End File Contents#
        This will look in the same folder for a file called change-gitsignature.ps1, and import it on launch of powershell.
    #>
    param(
        [Parameter(Mandatory=$true, ParameterSetName="personal", HelpMessage="Switch: Configures git to use your personal or work GPG key to sign commits")]
            [switch]
            $personal #Switch: Configures git to use your personal GPG key and email to sign commits
        ,[Parameter(Mandatory=$true, ParameterSetName="work")]
            [switch]
            $work #Switch: Configures git to use your work GPG key and email to sign commits
    )
    $csv = Import-CSV "~\.gnupg\key_ids.csv"
    if($personal){
        $type = "Personal"
        $entry = $csv.Where({$PSItem.type -eq "$type"})
        $id = $entry.id
        $email = $entry.email
        write-debug "$type ID: $id" 
        git config --global user.signingkey $id
        write-debug "$type Email: $email"
        git config --global user.email $email
    }
    if($work){
        $type = "Work"
        $entry = $csv.Where({$PSItem.type -eq "$type"})
        $id = $entry.id
        $email = $entry.email
        write-debug "$type ID: $id" 
        git config --global user.signingkey $id
        write-debug "$type Email: $email"
        git config --global user.email $email
    }
    $key = git config --get user.signingkey
    $email = git config --get user.email
    $output = "Git ID: $key`nGit Email: $email"
    write-debug "$output"
}
