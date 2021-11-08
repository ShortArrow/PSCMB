@echo off
cd /d "%userprofile%\Documents\CustomContextMenu\"
pwsh -NoProfile -ExecutionPolicy Unrestricted Create-7zWithPassword.ps1 %*
exit
