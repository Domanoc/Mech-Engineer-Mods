function Write-Buffer {
    param(
        [Parameter(Mandatory = $true)]
        $buffer,
        [Parameter(Mandatory = $true)]
        $writer
    )

    foreach ($b in $buffer) {
        $writer.WriteLine($b)
    }
}

function Write-DocumentationFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [Parameter(Mandatory = $true)]
        [string]$OutputFile
    )

    # Line Buffer
    $buffer = @()

    $reader = [System.IO.StreamReader]::new($FilePath)
    $writer = [System.IO.StreamWriter]::new($OutputFile, $false)

    $LineBreakWasWritten = $true
    $HasFoundLocal = $false

    try {
        $writer.WriteLine("---@meta")
        $writer.WriteLine("")

        while ($null -ne ($line = $reader.ReadLine())) {
            
            if ([string]::IsNullOrWhiteSpace($line)) {
                if (-not $LineBreakWasWritten) {
                    $writer.WriteLine("")
                    $LineBreakWasWritten = $true
                }

                # Clear the buffer
                $buffer = @()
                continue
            }

            if ($line.StartsWith("---@type")) {
                $line = $line -replace "^---@type", "---@class"
            }

            if ($line.StartsWith('---')) {
                $buffer += $line
                continue
            }

            if ($line.StartsWith('local ') -and -not $HasFoundLocal -and $line -notmatch "require\(.+\)$") {
                Write-Buffer $buffer $writer
                # Clear the buffer
                $buffer = @()
                $writer.WriteLine($line)

                $LineBreakWasWritten = $false
                $HasFoundLocal = $true
                continue
            }

            if ($line.StartsWith('function ') -and -not $line.StartsWith("function Private")) {
                Write-Buffer $buffer $writer
                # Clear the buffer
                $buffer = @()
                $writer.WriteLine("$line end")

                $LineBreakWasWritten = $false
                continue
            }

            if ($line.StartsWith('return ')) {
                Write-Buffer $buffer $writer
                # Clear the buffer
                $buffer = @()
                $writer.WriteLine($line)

                $LineBreakWasWritten = $false
                continue
            }
        }
    }
    catch {
        Write-Error $_
        throw
    }
    finally {
        $reader.Close()
        $writer.Flush()
        $writer.Close()
    }
}

function Write-FullDocumentationFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [Parameter(Mandatory = $true)]
        [string]$OutputFile
    )

    # Line Buffer
    $buffer = @()

    $reader = [System.IO.StreamReader]::new($FilePath)
    $writer = [System.IO.StreamWriter]::new($OutputFile, $false)

    $LineBreakWasWritten = $true

    try {
        $writer.WriteLine("---@meta")
        $writer.WriteLine("")

        while ($null -ne ($line = $reader.ReadLine())) {

            if ([string]::IsNullOrWhiteSpace($line)) {
                if (-not $LineBreakWasWritten) {
                    $writer.WriteLine("")
                    $LineBreakWasWritten = $true
                }

                # Clear the buffer
                $buffer = @()
                continue
            }

            if ($line.StartsWith('---')) {
                $buffer += $line
                continue
            }

            if (-not [string]::IsNullOrWhiteSpace($line)) {
                Write-Buffer $buffer $writer
                # Clear the buffer
                $buffer = @()

                $writer.WriteLine($line)

                $LineBreakWasWritten = $false
                continue
            }
        }
    }
    catch {
        Write-Error $_
        throw
    }
    finally {
        $reader.Close()
        $writer.Flush()
        $writer.Close()
    }
}

function Write-DocumentationFiles {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FolderPath,
        [Parameter(Mandatory = $true)]
        [string]$OutputFolder
    )

    if (-Not (Test-Path $FolderPath)) {
        Write-Error "Path does not exist: $FolderPath"
        return
    }

    $items = Get-ChildItem -Path $FolderPath

    foreach ($item in $items) {
        $FilePath = "$($item.FullName)"
        $OutputFile = "$OutputFolder$($item.Name).d.lua"

        if($($item.Name) -eq "ModFramework.lua") {
            continue
        }

        if($($item.Name) -eq "ModFrameworkStorage.lua") {
            continue
        }

        if($($item.Name) -eq "ModFrameworkTypes.lua") {
            Write-FullDocumentationFile -FilePath $FilePath -OutputFile $OutputFile
            continue
        }

        Write-DocumentationFile -FilePath $FilePath -OutputFile $OutputFile
    }
}

$FolderPath = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework\ModFramework\"
$OutputFolder = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework\ModFrameworkDefinitions\Modules\"

Write-DocumentationFiles -FolderPath $FolderPath -OutputFolder $OutputFolder