# **Chef Server Demo (Unbuntu 14.04)**
    by Joaquin Menchaca
    November 15, 2015

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.

## **Instructions**

1. Download ChefDK - `./fetch-chefdk.sh`
2. Download ChefServer - `./fetch-chefserver.sh`
3. Create Environment `vagrant up`
4. (optional) Start Tunnel
   - Explore Chef Server `https://localhost`
5. Log into workstation `vagrant ssh`
6. Create Cookbooks, e.g. `cd ~/chef-repo; chef generate cookbook cookbooks/mywebserver`

## **Sample Script**

You can use test script under vagrant account to provision node:

```bash
$ vagrant ssh
vagrant@work:~$ bash /vagrant/test-chef.sh
```
