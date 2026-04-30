function MirrorFolder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SourceFolder,
        [Parameter(Mandatory = $true)]
        [string]$DestinationFolder
    )
    robocopy $SourceFolder $DestinationFolder /MIR /R:1 /W:3 /V /TEE /LOG+:ExportMods.log

    # Normalize exit codes (0–7 = success)
    if ($LastExitCode -gt 7) {
        exit $LastExitCode
    }
}

"" | Set-Content "MirrorDefinitions.log"


# ModFramework Source
$ModFrameworkSource = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework"
$ModFrameworkDestination = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\ModFramework"

MirrorFolder -SourceFolder $ModFrameworkSource -DestinationFolder $ModFrameworkDestination


# ModFramework Example Mod Source
$ModFrameworkExampleModSource = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework Example Mod"
$ModFrameworkExampleModDestination = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\ModFramework Example Mod"

MirrorFolder -SourceFolder $ModFrameworkExampleModSource -DestinationFolder $ModFrameworkExampleModDestination


# Combat Data Core Source
$CombatDataCoreSource = "D:\Mod Projects\Mech Engineer Mods\docs\Combat-Data-Core"
$CombatDataCoreDestination = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\_DEV_Combat Data Core"

MirrorFolder -SourceFolder $CombatDataCoreSource -DestinationFolder $CombatDataCoreDestination


exit 0