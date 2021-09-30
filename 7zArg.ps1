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
  $payload = '7z a ' + $(Join-Path $parent ($leafbase + $Extension) ) + ' ' + $file + ' -y' + ($withPassword ? (' -p"' + $password + '"') :'')
  Write-Host $payload
  Invoke-Expression $payload
}
