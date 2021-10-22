# How to get singleinstance.exe

## without build on powershell

```posh
mkdir SingleInstance
$url = https://github.com/zenden2k/context-menu-launcher/releases/latest/download/singleinstance.exe
$file = ./SingleInstance/singleinstance.exe
Invoke-WebRequest -Uri $url -OutFile $file
```
