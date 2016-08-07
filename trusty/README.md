# **Chef Server Demo (Unbuntu 14.04)**
    by Joaquin Menchaca
    Created: November 15, 2015
    Last Updated: August 7, 2016

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.

## **Instructions**

These were tested only on a host running **OS X** (10.11.6, 10.10.5, 10.8.5), but should work on **Linux**.  This has not been tested on **Windows**, and so may need some adjustments with **CygWin** and **GitBASH**.

### **PART I: Bring Up Vagrant Environment**

1. Create Environment `vagrant up`
* Explore Chef Server `https://192.168.51.3`
* Log into workstation `vagrant ssh`
* Create Cookbooks, e.g. `cd ~/chef-repo; chef generate cookbook cookbooks/mywebserver`

### **PART II: Logging In to Chef Server**

1. In web browser: `https://192.168.51.3`.
* You may have to confirm a security exception as the SSL certificate is self-signed.
* Log on using username and password of `vagrant`

### **PART III: Run Sample Chef Recipe**

You can use test script under vagrant account to provision node:

```bash
$ vagrant ssh
vagrant@workstation:~$ ./test_chef
```


#### **Encrypting Passwords with Key**

After the key is installed into your node, then you the process to encrypt passwords is the following:

1. Generate a Data Bag that will store the passwords, often called secrets or passwords.
2. Create JSON files meaningful to your environment that has the passwords, which should be encrypted.
3. Encrypt secrets used in Data Bag on the Chef Server.
4. Encrypt secrets used on disk (usually this is a repository managed by git, svn, or other tool).
5. Save code files with encrypted passwords into repository.

```bash
$ KEY_PATH="/home/${USER}/.chef/encrypted_data_bag_secret"
$ cd ~chef-repo
$ knife data bag create passwords  # create data bag on Chef Server
$ mkdir -p data_bags/passwords
$ cat <<-SECRET_EOF > data_bags/passwords/srv_pswd.json
{
  "id": "srv_pswd",
  "password": "vagrant"
}
SECRET_EOF
$ # upload encrypted data bag to Chef Server
$ knife data bag from file passwords srv_pswd.json --secret-file ${KEY_PATH}
$ # encrypt local copy of file
$ knife data bag from file passwords sql_server_root_password.json --secret-file ${KEY_PATH} --local-mode
```

#### **Referencing Encrypted Passwords in Recipees**

The sample cookbook will be called `my_server`.  This is how we can use it.

1. Optionally, specify default variable in attributes for the location of the secret key on the target node.  The key should be installed there previously.
2. Use `Chef::EncryptedDataBagItem` class to fetch the password.
3. Use the pasword to configure something.

```bash
$ KEY_NAME="encrypted_data_bag_secret"
$ COOKBOOK=${HOME}/chef-repo/my_server
$ cat <<-ATTRIBUTES_EOF >>${COOKBOOK}/attributes/default.rb
default['my_server']['passwords']['secret_path'] = "/etc/chef/${KEY_NAME}"
ATTRIBUTES_EOF
$ cat <<-COOKBOOK_EOF >>${COOKBOOK}/recipes/default.rb
# Load the secrets file
secret_path = node['my_server']['passwords']['secret_path']
secret      = Chef::EncryptedDataBagItem.load_secret(secret_path)
passwd      = Chef::EncryptedDataBagItem.load('passwords', 'srv_pswd', secret)

# Configure something
mysql_service 'default' do
  initial_root_password passwd['password']
  action [:create, :start]
end
COOKBOOK_EOF
```
