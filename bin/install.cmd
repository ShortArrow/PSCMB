@echo off
echo "setup PSCMB"
pushd %~dp0
pwsh -NoProfile -ExecutionPolicy Unrestricted "./Install-To-ContextMenu.ps1"
pause > nul
exit