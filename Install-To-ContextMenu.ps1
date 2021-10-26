# Where is this folder
$HerePath = (Get-Location).Path
# Get distination path
$Distination = "$env:USERPROFILE/Documents/CustomContextMenu"
$SendtoPath = "$env:APPDATA/Microsoft/Windows/SendTo"
$RegistryShellRoot = "HKCR:/*/shell"
$RegistryShellAppRootName = "PSCMB"
$RegistryShellAppCommandMultiZipName = "Make zips"
$RegistryShellAppCommandMultiZipWithPasswordName = "Make zips with password"
$RegistryShellAppCommandMulti7zName = "Make 7zips"
$RegistryShellAppCommandMulti7zWithPasswordName = "Make 7zips with password"
$RegistryShellAppCommandMakeListName = "Make List to Clip"

$url = "https://github.com/zenden2k/context-menu-launcher/releases/latest/download/singleinstance.exe"
$singleinstancefile = "./SingleInstance/singleinstance.exe"
if (!(Test-Path $singleinstancefile)) {
    New-Item SingleInstance -Force -ItemType Directory
    Invoke-WebRequest -Uri $url -OutFile $singleinstancefile
} 

if (Test-Path $Distination) {

}
else {
    mkdir $Distination
}

# Get Children
$children = Get-ChildItem $HerePath
foreach ($child in $children) {
    if (!$child.PSIsContainer -and $child.Extension -eq ".cmd") {
        Copy-Item -Path $child -Destination $SendtoPath -Force
    }
    Copy-Item -Path $child -Destination $Distination -Force
}

New-PSDrive -PSProvider "registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Scope Script
Set-Location -LiteralPath $RegistryShellRoot
New-Item $RegistryShellAppRootName -Force
Set-Location $RegistryShellAppRootName
$Here = (Get-Location) -replace "HKCR:", "HKEY_CLASSES_ROOT"
[Microsoft.Win32.Registry]::SetValue($Here, "MUIVerbs", "BoostMenu", [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue($Here, "SubCommands", "", [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue($Here, "Icon", "$env:ProgramFiles\7-Zip\7z.dll,0", [Microsoft.Win32.RegistryValueKind]::ExpandString)
[Microsoft.Win32.Registry]::SetValue($Here, "MultiSelectModel", "Player", [Microsoft.Win32.RegistryValueKind]::String)
New-Item "shell" -Force
Set-Location "shell"
New-Item $RegistryShellAppCommandMultiZipName -Force
New-Item $RegistryShellAppCommandMultiZipWithPasswordName -Force
New-Item $RegistryShellAppCommandMulti7zName -Force
New-Item $RegistryShellAppCommandMulti7zWithPasswordName -Force
New-Item $RegistryShellAppCommandMakeListName -Force
foreach ($item in $(Get-ChildItem)) {
    Set-Location (Split-Path $item.Name -Leaf)
    $Here = (Get-Location) -replace "HKCR:", "HKEY_CLASSES_ROOT"
    [Microsoft.Win32.Registry]::SetValue($Here, "MultiSelectModel", "Player", [Microsoft.Win32.RegistryValueKind]::String)
    New-Item "command" -Force
    Set-Location ..
}
$Here = (Get-Location) -replace "HKCR:", "HKEY_CLASSES_ROOT"
$DistinationBack = $Distination -replace "/", "\"
[Microsoft.Win32.Registry]::SetValue("$Here\$RegistryShellAppCommandMultiZipName\command", "", '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make Zip from Files .cmd" $files  --si-timeout 400', [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue("$Here\$RegistryShellAppCommandMultiZipWithPasswordName\command", "", '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make Zip from Files with Password .cmd" $files  --si-timeout 400', [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue("$Here\$RegistryShellAppCommandMulti7zName\command", "", '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make 7z from Files .cmd" $files  --si-timeout 400', [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue("$Here\$RegistryShellAppCommandMulti7zWithPasswordName\command", "", '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make 7z from Files with Password .cmd" $files  --si-timeout 400', [Microsoft.Win32.RegistryValueKind]::String)
[Microsoft.Win32.Registry]::SetValue("$Here\$RegistryShellAppCommandMakeListName\command", "", '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make List from Files .cmd" $files  --si-timeout 400', [Microsoft.Win32.RegistryValueKind]::String)

Set-Location $HerePath

if (Test-Path $singleinstancefile) {
    Copy-Item -Destination "$Distination\SingleInstance" -LiteralPath $singleinstancefile -Force
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

Remove-PSDrive -Name "HKCR" -Force

Write-Host "Finish Setup" -ForegroundColor White -BackgroundColor Green
