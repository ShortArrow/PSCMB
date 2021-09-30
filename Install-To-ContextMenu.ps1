# Where is this folder
$HerePath = (Get-Location).Path
# Get distination path
$Distination = "$env:USERPROFILE/Documents/CustomContextMenu"
$SendtoPath = "$env:APPDATA/Microsoft/Windows/SendTo"

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
