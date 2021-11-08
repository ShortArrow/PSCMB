@echo off
cd /d "%userprofile%\Documents\CustomContextMenu\"
pwsh -NoProfile -ExecutionPolicy Unrestricted Set-ListToClipBoardWithoutExtensions.ps1 %*
exit