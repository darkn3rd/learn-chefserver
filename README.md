# **Chef Server Demo (Cent OS 7)**
by Joaquin Menchaca
November 15, 2015

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.

## **Notes**

This system is self contained and should work properly on your host system (tested with ***OS X Yosemite***).  The systems share the same private virtual network, and thus all IP addresses used on the network, e.g. `vboxnet0`, need to be unique.

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
