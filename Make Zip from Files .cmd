@echo off
cd "%userprofile%\Documents\CustomContextMenu\"
pwsh -NoProfile -ExecutionPolicy Unrestricted Create-Zip.ps1 %*
exit
