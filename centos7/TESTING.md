# **Tested Platforms**

* Host OS:
    * Mac OS X 10.8.5, 10.10.5, 10.11.6
    * Fedora 20
    * Windows 10 Home
* Guest OS:
    * RHEL7 (CentOS 7)
* Applications:
    *  Chef Server 12.3
       * Reporting 1.5.5
       * Management 1.21
    *  ChefDK 0.10
    *  Chef client 12.5.1

## **Certified Broken**

|Host                  |Guest                                 |Vagrant|Driver     |
|----------------------|--------------------------------------|-------|-----------|
|MacOS X 10.11.6       |CentOS 7 (`centos/7` 1606.01)         |1.8.5  |VBox 5.1.2 |
|MacOS X 10.11.6       |CentOS 7 (`geerlingguy/centos7` 1.1.3)|1.8.5  |VBox 5.1.2 |
|MacOS X 10.11.6       |CentOS 7 (`centos/7` 1606.01)         |1.8.4  |VBox 5.0.26|


**NOTES**
* _Warning: Authentication failure. Retrying... " after packaging box_ ([Vagrant #5186](https://github.com/mitchellh/vagrant/issues/5186))
  * Vagrant 1.8.5 + Cent OS 7
* _VirtualBox Guest Additions in Vagrant image_ ([CentOS/sig-cloud-instance-build #27](https://github.com/CentOS/sig-cloud-instance-build/issues/27))
  * Vagrant 1.8.4 + Cent OS 7 (`centos/7`)

The [centos/7 vagrant image](https://seven.centos.org/2016/07/updated-centos-vagrant-images-available-2/) does not have Guest Editions, which goes against the community standard and default behavior of Vagrant.  The author wants you do turn off default sync, and requires you to install Ansible.


## **Certified Works**

|Host                        |Guest                                  |Vagrant|Driver     |
|----------------------------|---------------------------------------|-------|-----------|
|Fedora 20 *Heisenbug*       |CentOS 7 (`geerlingguy/centos7`)       |1.7.4  |VBox 4.3.34|
|MacOS X 10.11.6             |CentOS 7 (`geerlingguy/centos7` 1.1.3) |1.8.4  |VBox 5.0.26|
|MacOS X 10.8.5              |CentOS 7 (`geerlingguy/centos7`)       |1.7.4  |VBox 4.3.20|
|MacOS X 10.10.5             |CentOS 7 (`geerlingguy/centos7`)       |1.7.4  |VBox 5.0.10|
|Windows 7 (WinNT 6.1)       |CentOS 7 (`geerlingguy/centos7`)       |1.7.4  |VBox 5.0.10|
|Windows 10 Home (WinNT 6.4) |CentOS 7 (`geerlingguy/centos7`)       |1.7.4  |VBox 5.0.10|
