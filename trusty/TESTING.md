# Tested Platforms

Manual Testing:

  * Host OS:
      * Mac OS X 10.8.5, 10.10.5, 10.11.6
      * Fedora 20
      * Windows 10 Home
  * Guest OS:
      * Ubuntu 14.04 Trusty Tahr
  * Applications:
      *  Chef Server 12.3
         * Reporting 1.5.5
         * Management 1.21
      *  ChefDK 0.10
      *  Chef client 12.5.1

## **Certified Works**

|Host                  |Guest                                     |Vagrant|Driver     |
|----------------------|------------------------------------------|-------|-----------|
|Fedora 20 *Heisenbug* |CentOS 7 (`ubuntu/trusty64`)              |1.7.4  |VBox 4.3.34|
|MacOS X 10.11.6       |CentOS 7 (`ubuntu/trusty64` 20160801.0.0 )|1.8.5  |VBox 5.1.2 |
|MacOS X 10.8.5        |CentOS 7 (`ubuntu/trusty64`)              |1.7.4  |VBox 4.3.20|
|MacOS X 10.10.5       |CentOS 7 (`ubuntu/trusty64`)              |1.7.4  |VBox 5.0.10|
|Windows 10 Home       |CentOS 7 (`ubuntu/trusty64`)              |1.7.4  |VBox 5.0.10|

## **Test Platform**

Host:
  * MacBookPro 11,5 (2.5GHz Intel Core i7, 16 GB RAM)
  * Mac OS X 10.11.6, Vagrant 1.8.4, VirtualBox 5.0.26
Guest Timings:
  * Ubuntu 14.04 Trusty Tahr (packages downloaded previously)
      * `vagrant up --no-provision`: 1m37.343s
      * `vagrant provision chefserver`: 6m34.131s
      * `vagrant provision workstation`: 0m19.836s
      * `vagrant provision node`: 0m9.447s
      * `test_chef`: 0m9.188s
  * Ubuntu 14.04 Trusty Tahr
      * `vagrant up`: 14m9.589s
