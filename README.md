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

### **Provisioning**

The provisioning shell scripts are very simple, and work on fresh clean systems.  They have some intelligence to not cause problems if provisioned again (idempotent).  They are not smart enough to check for versions, so will not do upgrades, e.g. if ChefDK 0.9 is installed, a new package of ChefDK 0.10 won't be installed.  Upgrading new versions will have to be done manually.

## **Requirements**
  * All Systems (Win, Linux, OS X)
    * [VirtualBox](https://www.virtualbox.org/) 5.0.26 - required virtual system
    * [Vagrant](https://www.vagrantup.com/) 1.8.4 - virtual system automation tools
      * Vagrant 1.8.5 is incompatible with CentOS (RHEL), so don't use it.
  * Linux or OS X
    * `curl` command-line tool
  * Windows
    * PowerShell 2.0+ (for optional [Chocolately](https://chocolatey.org/))
    * [CygWin](https://www.cygwin.com/) with [Apt-Cyg](https://github.com/transcode-open/apt-cyg) (Optional)

### **Homebrew and Homebrew Cask**

I do ***NOT*** recommend [Cask](https://caskroom.github.io/) with [Homebrew](http://brew.sh/) as there currently is no support for versioning.  Cask may install a broken version of Vagrant that is incompatible with basic CentOS (RHEL) 7 operating system as the guest OS.

### **CygWin and Apt-Cyg**

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
