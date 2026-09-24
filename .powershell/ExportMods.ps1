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

"" | Set-Content "ExportMods.log"


# ModFramework Source
$ModFrameworkSource = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework"
$ModFrameworkDestination = "D:\Steam\steamapps\workshop\content\1428520\3717805872"
$ModFrameworkDestination2 = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\ModFramework"

MirrorFolder -SourceFolder $ModFrameworkSource -DestinationFolder $ModFrameworkDestination
MirrorFolder -SourceFolder $ModFrameworkSource -DestinationFolder $ModFrameworkDestination2


# ModFramework Example Mod Source
$ModFrameworkExampleModSource = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework Example Mod"
$ModFrameworkExampleModDestination = "D:\Steam\steamapps\workshop\content\1428520\3717807705"
$ModFrameworkExampleModDestination2 = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\ModFramework Example Mod"

MirrorFolder -SourceFolder $ModFrameworkExampleModSource -DestinationFolder $ModFrameworkExampleModDestination
MirrorFolder -SourceFolder $ModFrameworkExampleModSource -DestinationFolder $ModFrameworkExampleModDestination2


# Combat Data Core Source
$CombatDataCoreSource = "D:\Mod Projects\Mech Engineer Mods\src\Combat Data Core"
$CombatDataCoreDestination = "D:\Steam\steamapps\workshop\content\1428520\3581427607"
$CombatDataCoreDestination2 = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\Combat Data Core"

MirrorFolder -SourceFolder $CombatDataCoreSource -DestinationFolder $CombatDataCoreDestination
MirrorFolder -SourceFolder $CombatDataCoreSource -DestinationFolder $CombatDataCoreDestination2


# Direct Control Source
$DirectControlSource = "D:\Mod Projects\Mech Engineer Mods\src\Direct Control"
$DirectControlDestination = "D:\Steam\steamapps\workshop\content\1428520\3722622126"
$DirectControlDestination2 = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\Direct Control"

MirrorFolder -SourceFolder $DirectControlSource -DestinationFolder $DirectControlDestination
MirrorFolder -SourceFolder $DirectControlSource -DestinationFolder $DirectControlDestination2


# DebuggerCheat Source
$DirectControlSource = "D:\Mod Projects\Mech Engineer Mods\src\DebuggerCheat"
$DirectControlDestination = "C:\Users\mail\AppData\Local\Mech_Engineer\mods\DebuggerCheat"

MirrorFolder -SourceFolder $DirectControlSource -DestinationFolder $DirectControlDestination

(New-Object Media.SoundPlayer "C:\Windows\Media\Windows Notify Messaging.wav").PlaySync()

exit 0