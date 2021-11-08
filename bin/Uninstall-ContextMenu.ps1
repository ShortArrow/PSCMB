$AppPath = "$env:USERPROFILE/Documents/CustomContextMenu"
Remove-Item $AppPath -Force -Recurse

$SendtoPath = "$env:APPDATA/Microsoft/Windows/SendTo"
$DeleteFiles = @(
    "Make 7z from Files .cmd",
    "Make 7z from Files with Password .cmd",
    "Make List from Files .cmd",
    "Make Zip from Files .cmd",
    "Make Zip from Files with Password .cmd",
    "Make List from Files without Extensions .cmd"
)
foreach ($item in $DeleteFiles) {
    Remove-Item (Join-Path $SendtoPath -ChildPath $item) -Force
}

$RegistryShellRoot = "HKCR:/*/shell"
$RegistryShellAppRootName = "PSCMB"
$HKCR = New-PSDrive -PSProvider "registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Scope Script
Set-Location -LiteralPath $RegistryShellRoot
Remove-Item $RegistryShellAppRootName -Force -Recurse
Remove-PSDrive -Name $HKCR.Name -Force

$finishTitle = "7zip Multi"
$finishMessage = 'Uninstall Finished, Celebrate!'
if ([environment]::OSVersion.Version.Major -ge 10 ) {
    $ToastModulePath = $env:USERPROFILE + "\Documents\PowerShell\Modules\BurntToast"
    if (!(Test-Path $ToastModulePath)) {
        Copy-Item -Destination $ToastModulePath -LiteralPath ".\BurntToast\BurntToast" -Force -Recurse
    }
    Import-Module BurntToast
    New-BurntToastNotification -Text $finishTitle, $finishMessage
}
else {
    $ws = New-Object -com Wscript.Shell
    $ws.Popup($finishMessage, 0, $finishTitle, 0)
}

Write-Host ""
Write-Host "Finish Uninstall" -ForegroundColor White -BackgroundColor Green 
