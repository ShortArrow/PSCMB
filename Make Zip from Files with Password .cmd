@echo off
cd "%userprofile%\Documents\CustomContextMenu\"
pwsh -NoProfile -ExecutionPolicy Unrestricted Create-ZipWithPassword.ps1 %*
exit
