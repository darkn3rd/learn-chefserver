# **Chef Server Demo Overview**
    by Joaquin Menchaca
    November 15, 2015

Welcome to Chef Server Demo.  Use the instructions in `trusty/` or `centos7/` directories to bring up the Chef Server, development workstation, and single node system to cofigure.

## **Notes**

This system is self contained and should work properly on Linux/Unix host systems (tested on ***OS X 10.10.5 Yosemite*** and ***OS X 10.8.5 Mountain Lion***).  To keep things simple, the guest operating systems are all running CentOS 7 or Ubuntu 14.04 Trusty Tahr.

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
  * Windows
    * PowerShell 2.0+

## **Recommendations**

### **OS X**

* [Homebrew](http://brew.sh/) - coomand-line tool for installing tools and libraries
* [Cask](http://caskroom.io/) - command-line tool for installing full applications

With these tools you can install the needed requirements like this:

```bash
$ brew install wget
$ brew cask install virtualbox
$ brew cask install vagrant
```

### **Windows**

* [Chocolately](https://chocolatey.org/) - command-line tool for installing open-source tools
* [CygWin](https://www.cygwin.com/) - Unix/Linux command-line tools.
* [Apt-Cyg](https://github.com/transcode-open/apt-cyg) - command tool for installing CygWin packages from the command-line

With these tools, you could install

```batch
C:\> choco install cygwin
C:\> choco install virtualbox
C:\> choco install vagrant
```
