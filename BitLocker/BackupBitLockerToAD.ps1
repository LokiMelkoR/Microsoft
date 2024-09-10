<#
    This backsup your device bitlocker key to the Active Directory
#>


Backup-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId ((Get-BitLockerVolume -MountPoint $env:SystemDrive ).KeyProtector | Where-Object {$_.KeyProtectorType -eq "RecoveryPassword" }).KeyProtectorId


<#
After that you can use following to export Bitlocker data to a text tile.

Use the “$exportLocation” as you like

$Computers = Get-ADComputer -Filter *
$exportLocation = 'C:\temp\Bitlocker-AD-Export.txt'
foreach ($computer in $computers) {
    #$objComputer = Get-ADComputer $computer
    if ($Bitlocker_Object = Get-ADObject -Filter { objectclass -eq 'msFVE-RecoveryInformation' } -SearchBase $computer.DistinguishedName -Properties 'msFVE-RecoveryPassword' | Select-Object -ExpandProperty 'msFVE-RecoveryPassword') {
        Add-Content -Value "$computer $Bitlocker_Object" -Path $exportLocation
    }
}
#>
