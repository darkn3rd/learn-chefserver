# **Chef Server Demo (Cent OS 7)**
    by Joaquin Menchaca
    November 15, 2015

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.
## **Instructions**

These were tested only on a host running **OS X** (10.10.5 and 10.8.5), but should work on **Linux**.  This has not been tested on **Windows**, and so may need some adjustments with **CygWin** and **GitBASH**.

### **PART I: Download Packages**

On OS X or Linux:

```bash
$ cd packages
$ ./fetch-chefdk.sh
$ ./fetch-chefserver.sh
$ cd ..
```

On Windows:

This will require PowerShell profile configured to allow user to execute PowerShell Scripts. See [Set-ExecutionPolicy](https://technet.microsoft.com/en-us/library/hh849812.aspx).

```batch
PS C:\learn-chefserver\centos7> cd packages
PS C:\learn-chefserver\centos7\packages> .\fetch-chefdk.ps1
PS C:\learn-chefserver\centos7\packages> .\fetch-chefserver.ps1
PS C:\learn-chefserver\centos7\packages> cd ..
```

### **PART II: Bring Up Vagrant Environment**

3. Create Environment `vagrant up`
4. (optional) Start Tunnel `sh ssh-tunnel.sh`
   - Explore Chef Server `https://localhost`
5. Log into workstation `vagrant ssh`
6. Create Cookbooks, e.g. `cd ~/chef-repo; chef generate cookbook cookbooks/mywebserver`

### **PART III: Sample Script**

You can use test script under vagrant account to provision node:

```bash
$ vagrant ssh
vagrant@work:~$ bash /vagrant/test-chef.sh
```
