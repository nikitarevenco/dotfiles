param (
    [string[]]$Paths
)

Add-Type -AssemblyName Microsoft.VisualBasic

foreach ($Path in $Paths) {
    if (Test-Path $Path -PathType Leaf) {
        # It's a file
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($Path, 'SendToRecycleBin', 'ThrowIfMissing', 'DeleteReadOnly')
    } elseif (Test-Path $Path -PathType Container) {
        # It's a directory
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($Path, 'SendToRecycleBin', 'ThrowIfMissing')
    } else {
        Write-Host "Path not found: $Path"
    }
}
