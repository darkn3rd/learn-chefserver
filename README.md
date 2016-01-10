# **Chef Server Demo Overview**
    by Joaquin Menchaca
    Copyright 2015 Joaquin Menchaca,
    License:  Attribution CC BY -
      https://creativecommons.org/licenses/by/4.0/legalcode
    November 15, 2015

Welcome to Chef Server Demo.  You can bring up complete Chef Servers on your laptop (or desktop) without the need to create accounts on some online system for Chef Server access or virtual systems.  These scripts only require some command line tools and [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) applications.

Use the instructions in `trusty/` or `centos7/` directories to bring up the Chef Server, development workstation, and single node system to configure.

## **Notes**

This system is self contained and should work properly on Linux/Unix host systems. To keep things simple, the guest operating systems are all running CentOS 7 or Ubuntu 14.04 Trusty Tahr.

PowerShell fetch scripts have been tested on Windows 7 SP1 (WinNT 6.1) with PowerShell 1.0.

### **VirtualBox's Private Network**

All the guest systems share the same private virtual network in VirtualBox, e.g. `vboxnet0`, and thus all IP addresses for the guest systems used need to be unique.

All systems can be brought up in about 7 to 8 minutes (with Ubuntu Trusty Tahr) on a OS X 10.10.5 host.

### **Provisioning**

The provisioning shell scripts are very simple, and work on fresh clean systems.  They have some intelligence to not cause problems if provisioned again (idempotent).  They are not smart enough to check for versions, so will not do upgrades, e.g. if ChefDK 0.9 is installed, a new package of ChefDK 0.10 won't be installed.  Upgrading new versions will have to be done manually.

## **Requirements**
  * All Systems (Win, Linux, OS X)
    * [VirtualBox](https://www.virtualbox.org/) - required virtual system
    * [Vagrant](https://www.vagrantup.com/) - virtual system automation tools
  * Linux or OS X
    * `wget` command-line tool
    * `curl` command-line tool
  * Windows
    * PowerShell 2.0+

## **Recommendations**

### **OS X**

* [XCode](https://developer.apple.com/xcode/) Command Line Tools - From AppStore or https://developer.apple.com.
* [Homebrew](http://brew.sh/) - coomand-line tool for installing tools and libraries
* [Cask](http://caskroom.io/) - command-line tool for installing full applications

With these tools you can install the needed requirements like this:

```bash
$ brew install wget
$ brew cask install virtualbox
$ brew cask install vagrant
```

### **Windows**

* [Git for Windows](https://git-for-windows.github.io/) - Git tools and Bash shell for Windows.
* [Chocolately](https://chocolatey.org/) - command-line tool for installing open-source tools and applications.
* [CygWin](https://www.cygwin.com/) - Unix/Linux command-line tools.
* [Apt-Cyg](https://github.com/transcode-open/apt-cyg) - command tool for installing CygWin packages from the command-line

#### **Chocolately**

With  [Chocolately](https://chocolatey.org/), you can easily install applications from the Internet.

```batch
C:\> choco install cygwin
C:\> choco install virtualbox
C:\> choco install vagrant
```

#### **Git For Windows**

[Git for Windows](https://git-for-windows.github.io/) comes bundled with a bash environment.  This comes with the `curl` command, but not `wget`.  You can download ChefClient and ChefDK using shell scripts, and use PowerShell for to download ChefServer and ChefServer packages.

#### **CygWin and Apt-Cyg**

Assuming the [CygWin](https://www.cygwin.com/) installer (`setup-x86_64.exe`) is in your local Downloads folder, you can do the following to install ***apt-cyg***:

```bash
$ cd $USERPROFILE/Downloads
$ ./setup-x86_64.exe -q -P wget
$ wget rawgit.com/transcode-open/apt-cyg/master/apt-cyg
$ chmod +x apt-cyg
$ mv apt-cyg /usr/local/bin/
```

Useful tools can then be installed in this fashion:

```bash
$ apt-cyg install curl
```

#### **PowerShell**

Optionally you can use PowerShell instead of shell scripts to download the packages.  If using PowerShell scripts (`.ps1`) in Windows Command Shell, Git-Bash, or CygWin, you need would need to run the script with these options:

```
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File myscript.ps1
```

## **Tested Platforms**

* Hosts
  * Fedora 20 *Heisenbug*, VirtualBox 4.3.34, Vagrant 1.7.4
  * OS X 10.8.5 *Mountain Lion*, Virtualbox 4.3.20, Vagrant 1.7.4
  * OS X 10.10.5 *Yosemite*, VirtualBox 5.0.10, Vagrant 1.7.4
  * Windows 10, VirtualBox 5.0.10, Vagrant 1.7.4
* Guests (chefserver, workstation, node)
  * Ubuntu 14.04 *Trusty Tahr*
  * CentOS 7
