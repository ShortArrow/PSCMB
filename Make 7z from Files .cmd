@echo off
cd /d "%userprofile%\Documents\CustomContextMenu\"
pwsh -NoProfile -ExecutionPolicy Unrestricted Create-7z.ps1 %*
exit
