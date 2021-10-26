# README

## PSCMB (Powershell Context Menu Booster)

This software extends the Windows context menu. And a tool created with powershell. We are aiming for something as powerful as the right head of Cerberus.

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

![img](Demo.png)
![img](Demo2.png)

## Author

[@ShortArrow](@ShortArrow)

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
