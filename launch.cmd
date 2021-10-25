@echo off
echo "plug on marionette!!"
pushd %~dp0
powershell -NoProfile -ExecutionPolicy Unrestricted "./Install-To-ContextMenu.ps1"
pause > nul
exit