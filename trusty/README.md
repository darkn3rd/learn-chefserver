# **Chef Server Demo (Unbuntu 14.04)**
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

This will require PowerShell profile configured to allow user to execute PowerShell Scripts. See [Set-ExecutionPolicy](https://technet.microsoft.com/en-us/library/hh849812.aspx).  These will have to be executed in PowerShell, unless care was taken to configure Powershell scripts to be executed under Command Shell.


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

### **PART III: Logging In to Chef Server**

On the host (Linux or OS X), you can run the ssh-tunnel script.  This will require root privileges (Linux and OS X).  Also, you can run only one tunnel at a time to a Chef Server in this environment.

```bash
$ sh ssh-tunnel.sh
```

Now you can use your web browser to open `https://127.0.0.1` and log in with `vagrant` as the user name and password.  You may have to confirm a security exception as the SSL certificate is self-signed.

### **PART IV: Run Sample Chef Recipe**

You can use test script under vagrant account to provision node:

```bash
$ vagrant ssh
vagrant@work:~$ bash /vagrant/test-chef.sh
```
