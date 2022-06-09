# Change-GitSignature.ps1
- version
    - 0.3
- Synopsis
    - Function to easily switch between GPG signatures and emails for git

## PARAMETERS 
|   PARAMATER NAME    |  DESCRIPTION  |
|   :---:   |   :---    |
|   personal  |    Switch: Configures git to use your personal GPG key and email to sign commits  |
|   work    |   Switch: Configures git to use your work GPG key and email to sign commits |

## NOTES
Author: @Halldk (Dustin Hall)

Uses a CSV file that has the key IDs of your GPG key, with a type either "work" or "personal" used to distinguish them. <br >
File expected to be in ~\.gnupg\key_ids.csv <br >
File format: 
``` 
type, id, email
work, fakekeyid1, work@email.com
personal, fakekeyid2, personal@email.com
```


To automatically load module into powershell for your profile, add to "~\Documents\WindowsPowershell\" folder and add to existing profile file. If no profile file exists, use this guide: <br >
path: ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 <br >
File contents:  
``` 
Import-Module $Profile\..\change-gitsignature.ps1
```

This will look in the same folder for a file called change-gitsignature.ps1, and import it on launch of powershell.
