# **Chef Server Demo (Unbuntu 14.04)**
    by Joaquin Menchaca
    November 15, 2015

Welcome to Chef Server Demo.  Use the instructions below to bring up environment with a Chef Server, Chef development workstation, and a single node to configure and test Chef workflow.

## **Instructions**

These were tested only on a host running **OS X** (10.10.5 and 10.8.5), but should work on **Linux**.  This has not been tested on **Windows**, and so may need some adjustments with **CygWin** and **GitBASH**.

### **PART I: Download Packages**

#### **Running Shell Scripts from BASH**

You need to have a POSIX shell installed, e.g. bash on Linux, OS X, or Windows with MSYS or CygWin to run these fetch scripts.  Additionally, you need to have the command line tools `curl` and `wget`

If you have `curl` installed (installed by default on Linux, OS X, or MSYS), you can run these:

```bash
$ cd packages
$ ./fetch-chefdk.sh
$ ./fetch-chefclient.sh
$ ./fetch-chefserver.sh # requires wget
$ # optional
$ ./fetch-packages.sh # requires wget
$ cd ..
```

#### **Running Powershell Scripts from BASH**

In MSYS or CygWin on Windows you can run these commands:

```bash
$ cd packages
$ alias pshell="powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File"
$ pshell fetch-chefdk.ps1
$ pshell fetch-chefclient.ps1
$ pshell fetch-chefserver.ps1
$ # optional
$ pshell fetch-packages.ps1
$ ..
```

#### **Running Powershell Scripts from CMD**

In Windows Command Shell (`cmd`), you can run these commands:

```batch
CD packages
DOSKEY pshell="powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File" $1
pshell fetch-chefdk.ps1
pshell fetch-chefclient.ps1
pshell fetch-chefserver.ps1
REM optional
pshell fetch-packages.ps1
CD ..
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
## **Generating Key**

If you need to encrypt your databags, you can generate a key locally.

### **Generate Secret Key**

#### **Shell**

```bash
$ cd .config
$ ./gen-databag-key.sh
$ cd ..
```

#### **PowerShell**

```powershell
PS C:\learn-chefserver\centos7> cd .config
PS C:\learn-chefserver\centos7\.config> .\gen-databag-key.ps1
PS C:\learn-chefserver\centos7\.config> cd ..
```

#### **Provision Node with Key**

```
vagrant provision node
```

#### **Encrypting Passwords with Key**

After the key is installed into your node, then you the process to encrypt passwords is the following:

1. Generate a Data Bag that will store the passwords, often called secrets or passwords.
2. Create JSON files meaningful to your environment that has the passwords, which should be encrypted.
3. Encrypt secrets used in Data Bag on the Chef Server.
4. Encrypt secrets used on disk (usually this is a repository managed by git, svn, or other tool).
5. Save code files with encrypted passwords into repository.

```bash
$ KEY_NAME="encrypted_data_bag_secret"
$ KEY_PATH="/vagrant/.config/${KEY_NAME}"
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
