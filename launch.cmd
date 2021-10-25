@echo off
echo "plug on marionette!!"
pushd %~dp0
pwsh -NoProfile -ExecutionPolicy Unrestricted "./Install-To-ContextMenu.ps1"
pause > nul
exit