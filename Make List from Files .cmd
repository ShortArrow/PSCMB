@echo off
cd /d "%userprofile%\Documents\CustomContextMenu\"
pwsh -NoProfile -ExecutionPolicy Unrestricted ClipBoardArg.ps1 %*
exit