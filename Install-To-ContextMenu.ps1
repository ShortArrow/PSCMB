# Where is this folder
$HerePath = (Get-Location).Path
# Get distination path
$Distination = "$env:USERPROFILE/Documents/CustomContextMenu"
$SendtoPath = "$env:APPDATA/Microsoft/Windows/SendTo"
$RegistryShellRoot = "HKEY_CLASSES_ROOT/*/shell/"
$RegistryShellAppRoot = Join-Path $RegistryShellRoot -ChildPath "./PSCMB/"
$RegistryShellAppCommandMultiZip = Join-Path $RegistryShellAppRoot -ChildPath "./Multi zip/"
$RegistryShellAppCommandMultiZipWithPassword = Join-Path $RegistryShellAppRoot -ChildPath "./Multi zip with password/"
$RegistryShellAppCommandMulti7z = Join-Path $RegistryShellAppRoot -ChildPath "./Multi 7z/"
$RegistryShellAppCommandMulti7zWithPassword = Join-Path $RegistryShellAppRoot -ChildPath "./Multi 7z with password/"

if (Test-Path $Distination) {

}
else {
    mkdir $Distination
}

# Get Children
$children = Get-ChildItem $HerePath
foreach ($child in $children) {
    if ((Split-Path $child -Extension) -eq ".cmd") {
        Copy-Item -Path $child -Destination $SendtoPath -Force
    }
    Copy-Item -Path $child -Destination $Distination -Force
}

$finishTitle = "7zip Multi"
$finishMessage = 'Install Finished, Celebrate!'
if ([environment]::OSVersion.Version.Major -ge 10 ) {
    $ToastModulePath = $env:USERPROFILE + "\Documents\PowerShell\Modules\BurntToast"
    if (!(Test-Path $ToastModulePath)) {
        Copy-Item -Destination $ToastModulePath -LiteralPath ".\BurntToast\BurntToast" -Force -Recurse
    }
    Import-Module BurntToast
    New-BurntToastNotification -AppLogo $($(Get-Location).Path + "\7zip.png") -Text $finishTitle, $finishMessage
}
else {
    $ws = New-Object -com Wscript.Shell
    $ws.Popup($finishMessage, 0, $finishTitle, 0)
}
