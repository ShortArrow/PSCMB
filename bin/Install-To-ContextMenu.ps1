Set-Location ..
# Where is this folder
$HerePath = (Get-Location).Path
# Get distination path
$Distination = "$env:USERPROFILE/Documents/CustomContextMenu"
$SendtoPath = "$env:APPDATA/Microsoft/Windows/SendTo"
$DistinationBack = $Distination -replace "/", "\"
$RegistryShellRoot = "HKCR:/*/shell"

$RegistryDictionary = @{
    "PSCMB" = @{
        isContainer        = $true;
        "MUIVerbs"         = @{
            isContainer       = $false;
            Name              = "BoostMenu";
            RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
        };
        "SubCommands"      = @{
            isContainer       = $false;
            Name              = ""; 
            RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
        };
        "Icon"             = @{
            isContainer       = $false;
            Name              = "$env:ProgramFiles\7-Zip\7z.dll,0";
            RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::ExpandString;
        };
        "MultiSelectModel" = @{
            isContainer       = $false;
            Name              = "Player";
            RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
        };
        "shell"            = @{
            isContainer                = $true;
            "Make zips"                = @{
                isContainer        = $true;
                "MultiSelectModel" = @{
                    isContainer       = $false;
                    Name              = "Player";
                    RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                };
                "command"          = @{
                    isContainer = $true;
                    "at"        = @{
                        isContainer       = $false;
                        Name              = '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make Zip from Files .cmd" $files  --si-timeout 400';
                        RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                    };
                };
            };
            "Make zips with password"  = @{
                isContainer        = $true;
                "MultiSelectModel" = @{
                    isContainer       = $false;
                    Name              = "Player";
                    RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                };
                "command"          = @{
                    isContainer = $true;
                    "at"        = @{
                        isContainer       = $false;
                        Name              = '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make Zip from Files with Password .cmd" $files  --si-timeout 400';
                        RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                    };
                };
            };
            "Make 7zips"               = @{
                isContainer        = $true;
                "MultiSelectModel" = @{
                    isContainer       = $false;
                    Name              = "Player";
                    RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                };
                "command"          = @{
                    isContainer = $true;
                    "at"        = @{
                        isContainer       = $false;
                        Name              = '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make 7z from Files .cmd" $files  --si-timeout 400';
                        RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                    };
                };
            };
            "Make 7zips with password" = @{
                isContainer        = $true;
                "MultiSelectModel" = @{
                    isContainer       = $false;
                    Name              = "Player";
                    RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                };
                "command"          = @{
                    isContainer = $true;
                    "at"        = @{
                        isContainer       = $false;
                        Name              = '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make 7z from Files with Password .cmd" $files  --si-timeout 400';
                        RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                    };
                };
            };
            "Make List to Clip"        = @{
                isContainer        = $true;
                "MultiSelectModel" = @{
                    isContainer       = $false;
                    Name              = "Player";
                    RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                };
                "command"          = @{
                    isContainer = $true;
                    "at"        = @{
                        isContainer       = $false;
                        Name              = '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make List from Files .cmd" $files  --si-timeout 400';
                        RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                    };
                };
            };
            "Make List to Clip without Extensions"        = @{
                isContainer        = $true;
                "MultiSelectModel" = @{
                    isContainer       = $false;
                    Name              = "Player";
                    RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                };
                "command"          = @{
                    isContainer = $true;
                    "at"        = @{
                        isContainer       = $false;
                        Name              = '"' + $DistinationBack + '\SingleInstance\singleinstance.exe" "%1" "' + $DistinationBack + '\Make List from Files without Extensions .cmd" $files  --si-timeout 400';
                        RegistryValueKind = [Microsoft.Win32.RegistryValueKind]::String;
                    };
                };
            };
        };
    };
}

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

function Set-Entry {
    param (
        [hashtable]
        $Entry,
        [string]
        $Name
    )
    if ($Name -eq "isContainer") {
        
    }
    else {
        if ($Entry.isContainer) {
            New-Item $Name -Force
            Set-Location $Name
            $Entry.Keys | ForEach-Object {
                if ($_ -ne "isContainer") {
                    Set-Entry -Entry $Entry.$_ -Name $_
                }
                Write-Host $_
            }
            Set-Location ..
        }
        else {
            $Here = (Get-Location) -replace "HKCR:", "HKEY_CLASSES_ROOT"
            [Microsoft.Win32.Registry]::SetValue(
                $Here, 
                (($Name -eq "at") ? "":$Name), 
                $Entry.Name,
                $Entry.RegistryValueKind
            )
        }
    }
}

New-PSDrive -PSProvider "registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Scope Script
Set-Location -LiteralPath $RegistryShellRoot
$RegistryDictionary.Keys | ForEach-Object { Set-Entry -Entry $RegistryDictionary.$_ -Name $_ }

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
