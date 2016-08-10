# **Chef Server Demo (Cent OS 7)**
    Copyright 2015 Joaquin Menchaca,
    License:  Attribution CC BY -
      https://creativecommons.org/licenses/by/4.0/legalcode
    November 15, 2015

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.

## **Instructions**

These fetch scripts have been tested on a host running **OS X 10.8.5**, **Fedora 20** Heisenbug, **Windows 7** (WinNT 6.1), and **Windows 10** (WinNT 6.4 in real life).  See [TESTING.md](TESTING.md) for more information.

This will ***NOT*** work on Vagrant 1.8.5 due to a current bug.

### **PART I: Bring Up Vagrant Environment**

3. Create Environment `vagrant up`
* Log into workstation `vagrant ssh`
* Create Cookbooks, e.g. `cd ~/chef-repo; chef generate cookbook cookbooks/mywebserver`

### **PART II: Logging In to Chef Server**

Navigate in your favorite web browser to https://192.168.50.6 , and confirm the security exception (because we are using self-signed certificates), and log in with `vagrant` for user name and password.

### **PART III: Run Sample Chef Recipe**

You can use test script under vagrant account to provision node:

```bash
$ vagrant ssh
vagrant@workstation:~$ ./test_chef
```

### **PART IV: Encrypting Passwords** (Optional)

See [SECRETKEY.md](SECRETKEY.md)
