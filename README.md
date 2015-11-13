# **Chef Server Demo Overview**
    by Joaquin Menchaca
    November 15, 2015

Welcome to Chef Server Demo.  Use the instructions in `trusty/` or `centos7/` directories to bring up the Chef Server, development workstation, and single node system to cofigure.

## **Notes**

This system is self contained and should work properly on your host system (tested on ***OS X 10.10.5 Yosemite***).  The systems share the same private virtual network, e.g. `vboxnet0`, and thus all IP addresses for the guest systems used need to be unique.

## **Requirements**
  * [VirtualBox](https://www.virtualbox.org/) - required virtual system
  * [Vagrant](https://www.vagrantup.com/) - virtual system automation tools
  * `wget` command-line tool

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
* [Apt-Cyg](https://github.com/transcode-open/apt-cyg) - command tool for installing CygWin packages

With these tools, you could install

```batch
C:\> choco install cygwin
C:\> choco install virtualbox
C:\> choco install vagrant
```

Then under CygWin, you can:

```bash
$ apt-cyg install wget
```
