function DeleteIfExists {
    param(
        [string]$File
    )

    if (Test-Path $File) {
        if (Get-Item $File -Force | Where-Object { $_.PSIsContainer }) {
            Remove-Item $File -Recurse -Force
            Write-Output "Directory '$File' and its contents have been deleted."
        } else {
            Remove-Item $File -Force
            Write-Output "File '$File' has been deleted."
        }
    } else {
        Write-Output "File or directory '$File' does not exist."
    }
}

# Get the current user's name
$userName = $env:USERNAME

# Construct the path based on the user's name
$basePath = "C:\Users\$userName\AppData\Local\Larian Studios\Baldur's Gate 3"

# Change to the target directory
Set-Location -Path $basePath

# List of files and folders to delete
$itemsToDelete = @(
    "analytics.lsx",
    "vkDeviceConfig.lsx",
    "graphicSettings.lsx",
    "pipelineCacheTimestampVk.bin",
    "PlayerProfiles/playerprofiles8.lsf",
    "PlayerProfiles/Public/config.lsf",
    "PlayerProfiles/Public/modsettings.lsx",
    "PlayerProfiles/Public/profile8.lsf",
    "PlayerProfiles/Public/UILayout.lsx",
    "Mods"
)

# Delete each item in the list
foreach ($item in $itemsToDelete) {
    DeleteIfExists -File $item
}

# Prevent the console from closing immediately
Read-Host -Prompt "Press Enter to exit"