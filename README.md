# README

## PSCMB (Powershell Context Menu Booster)

This software extends the Windows context menu. And a tool created with powershell. We are aiming for something as powerful as the right head of Cerberus.

## Features

These features can use from PSCMB or SendTo on contextmenu.
Let me know if you come up with a convenient and versatile right-click feature. I would appreciate it if you could make a pull request.

### Make multi zips

Create multiple zip files from multiple files.If it is only 7z, it will be one zip file. However, this will create a zip file with the same qty as the original file.

### Make multi zips with password

Create multiple zip files from multiple files with a password.

### Make multi 7zips

Create multiple 7zip files from multiple files.If it is only 7z, it will be one 7zip file. However, this will create a 7zip file with the same qty as the original file.

### Make multi 7zips with password

Create multiple 7zip files from multiple files with a password.

### Copy filenames to clipboard

Copy multiple filenames to the clipboard. Great for pasting a list of files into Excel, Google Sheets, etc.

## Requirement

* Powershell 6 or Later
* Windows 10 or Later
* 7Zip

## Installation

Download archive from release page, And unzip.
Then, please run `./bin/install.cmd` or `install.lnk`

## Uninstallation

Download archive from release page, And unzip.
Then, please run `./bin/uninstall.cmd` or `uninstall.lnk`

## Contribute

First action is `git clone`.

### BurntToast

Run `cd BurntToast`.
And run as described below, to get BurntToast.

```bash
git init BurntToast
git config core.sparsecheckout true
git remote add origin https://github.com/Windos/BurntToast.git
echo BurntToast > .git/info/sparse-checkout
git pull origin main 
```

### context-menu-launcher

Get process instance manager, like this.

```powershell
mkdir SingleInstance
$url = https://github.com/zenden2k/context-menu-launcher/releases/latest/download/singleinstance.exe
$file = ./SingleInstance/singleinstance.exe
Invoke-WebRequest -Uri $url -OutFile $file
```

Or this.

```bash
mkdir SingleInstance
if curl -s -L "https://github.com/zenden2k/context-menu-launcher/releases/latest/download/singleinstance.exe" -o "./SingleInstance/singleinstance.exe"; then
    echo downloaded
fi
```

### 7zip

please install 7zip and add to `path` environment variable.

if you use chocolatey you can install just as bellow.

```powershell
choco install 7zip
```

## Usage

Select multiple files and select Menu from the right-click menu, like demo after bellow.

### Demo

#### for files context menu

![img](img\demo_forfiles.png)

#### for folders context menu

![img](img\demo_forfolders.png)

#### for sendto context menu

![img](img\demo_sendto.png)

## Author

[@ShortArrow](https://github.com/ShortArrow)

## License

Under [MIT license](https://en.wikipedia.org/wiki/MIT_License).

## Release

First action is `git clone`. next, as described below.

```bash
git tag -a v1.0.0 -m 'version 1.0.0'
git push origin v1.0.0
```

## Dependency

- [Powershell](https://github.com/PowerShell/PowerShell)
- [BurntToast](https://github.com/Windos/BurntToast)
- [context-menu-launcher](https://github.com/zenden2k/context-menu-launcher)
- [7z](https://sourceforge.net/projects/sevenzip/files/7-Zip/)
