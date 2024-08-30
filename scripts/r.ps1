param (
    [string[]]$Paths
)

Add-Type -AssemblyName Microsoft.VisualBasic

foreach ($Path in $Paths) {
    # Check if the path exists
    if (Test-Path $Path) {
        try {
            # Check if it's a file
            if (Test-Path $Path -PathType Leaf) {
                Write-Host "Sending file to recycle bin: $Path"
                [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
                    $Path, 
                    [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs, 
                    [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin, 
                    [Microsoft.VisualBasic.FileIO.UICancelOption]::ThrowException
                )
            }
            # Check if it's a directory
            elseif (Test-Path $Path -PathType Container) {
                Write-Host "Sending directory to recycle bin: $Path"
                [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory(
                    $Path, 
                    [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs, 
                    [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin, 
                    [Microsoft.VisualBasic.FileIO.UICancelOption]::ThrowException
                )
            }
        } catch {
            Write-Host "An error occurred while processing '$Path': $_"
        }
    } else {
        Write-Host "Path not found: $Path"
    }
}
