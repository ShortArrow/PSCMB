param (
  [Parameter()]
  [string[]]
  $Files,
  [Parameter()]
  [string]
  $Extension = ".7z",
  [Parameter()]
  [switch]
  $withPassword = $false
)

$password = ""
if ($withPassword) {
  $failpassword = $false
  do {
    $password = Read-Host -Prompt "password"
    
    #region Sanitizing
    if ($password.IndexOf('$') -ne -1) {
      $failpassword = $true
      Write-Host "Can't include [$] for password"
    }
    elseif ($password.IndexOf('"') -ne -1) {
      $failpassword = $true
      Write-Host "Can't include [""] for password"
    }
    else {
      $failpassword = $false
    }
    #endregion

  } while ($failpassword)
}

foreach ($file in $Files) {
  $leafbase = Split-Path -LeafBase $file
  $parent = Split-Path -Parent $file
  $payload = '7z a "' + $(Join-Path $parent ($leafbase + $Extension) ) + '" "' + $file + '" -y' + ($withPassword ? (' -p"' + $password + '"') :'')
  Write-Host $payload
  Invoke-Expression $payload
}

$finishTitle = "7zip Multi"
$finishMessage = 'Mission Completed, Celebrate!'
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
