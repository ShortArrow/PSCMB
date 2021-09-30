@echo off
pushd %~dp0
cd ..
pwsh -NoProfile -ExecutionPolicy Unrestricted Install-To-ContextMenu.ps1
