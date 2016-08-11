# **Chef Server Demo (Unbuntu 14.04)**
    by Joaquin Menchaca
    Created: November 15, 2015
    Last Updated: August 7, 2016

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.

## **Instructions**

These were tested only on a host running **Mac OS X 10.8.5+**, and should work with **Windows 7+** and **Linux**, essentially wherever [Vagrant](vagrantup.com) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) can run.

### **PART I: Bring Up Vagrant Environment**

1. Create Environment `vagrant up`
* Log into workstation `vagrant ssh`
* Create Cookbooks, e.g. `cd ~/chef-repo; chef generate cookbook cookbooks/mywebserver`

### **PART II: Logging In to Chef Server**

1. In web browser: `https://192.168.51.3`.
* Confirm a security exception for self-signed certificate.
* Log on using username and password of `vagrant`

### **PART III: Run Sample Chef Recipe**

You can use test script under vagrant account to provision node:

```bash
$ vagrant ssh
vagrant@workstation:~$ ./test_chef
```

### **PART IV: Encrypting Passwords** (Optional)

See [SECRETKEY.md](SECRETKEY.md)
