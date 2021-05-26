# vagrant virtualbox box that has mysql - README.me with instructions

## Intro
This manual is dedicated to create vagrant virtualbox base ubuntu lts box with mysql-server package installed. Tested on Mac OS X.

## Requirements
- Oracle Virtualbox recent version installed
[VirtualBox installation manual](https://www.virtualbox.org/manual/ch01.html#intro-installing)

- Hashicorp packer recent version installed
[Packer installation manual](https://learn.hashicorp.com/tutorials/packer/getting-started-install)

- Hashicorp vagrant recent version installed
[Vagrant installation manual](https://learn.hashicorp.com/tutorials/vagrant/getting-started-install)

- git installed
[Git installation manual](https://git-scm.com/download/mac)

- have account created on [Vagrant cloud](https://app.vagrantup.com/)

## Preparation 
- Clone git repository. 

```bash
git clone https://github.com/antonakv/packer-mysql64
```

Expected command output looks like this:

```bash
Cloning into 'packer-mysql64'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 12 (delta 1), reused 3 (delta 0), pack-reused 0
Receiving objects: 100% (12/12), done.
Resolving deltas: 100% (1/1), done.
```

- Change folder to packer-mysql64

```bash
cd packer-mysql64
```

## Build
- In the same folder you were before run 

```bash
packer build template.json
```

Sample result

```bash
$ packer build template.json 
mysql64-vbox: output will be in this color.

==> mysql64-vbox: Retrieving Guest additions
==> mysql64-vbox: Trying /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso
==> mysql64-vbox: Trying /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso
==> mysql64-vbox: /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso => /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso
==> mysql64-vbox: Retrieving ISO
==> mysql64-vbox: Trying https://cdimage.ubuntu.com/releases/18.04/release/ubuntu-18.04.5-server-amd64.iso
==> mysql64-vbox: Trying https://cdimage.ubuntu.com/releases/18.04/release/ubuntu-18.04.5-server-amd64.iso?checksum=sha256%3A8c5fc24894394035402f66f3824beb7234b757dd2b5531379cb310cedfdf0996
==> mysql64-vbox: https://cdimage.ubuntu.com/releases/18.04/release/ubuntu-18.04.5-server-amd64.iso?checksum=sha256%3A8c5fc24894394035402f66f3824beb7234b757dd2b5531379cb310cedfdf0996 => /Users/aakulov/Documents/Development/Hashicorp/packer-mysql64/packer_cache/a37af95ab12e665ba168128cde2f3662740b21a2.iso
==> mysql64-vbox: Starting HTTP server on port 8549
==> mysql64-vbox: Creating virtual machine...
==> mysql64-vbox: Creating hard drive...
==> mysql64-vbox: Mounting ISOs...
    mysql64-vbox: Mounting boot ISO...
==> mysql64-vbox: Creating forwarded port mapping for communicator (SSH, WinRM, etc) (host port 2425)
==> mysql64-vbox: Executing custom VBoxManage commands...
    mysql64-vbox: Executing: modifyvm mysql64-vbox --memory 2048
    mysql64-vbox: Executing: modifyvm mysql64-vbox --cpus 2
==> mysql64-vbox: Starting the virtual machine...
    mysql64-vbox: The VM will be run headless, without a GUI. If you want to

[Removed some output]

==> mysql64-vbox: 16675+0 records in
==> mysql64-vbox: 16674+0 records out
==> mysql64-vbox: 17484939264 bytes (17 GB, 16 GiB) copied, 13.5125 s, 1.3 GB/s
==> mysql64-vbox: Gracefully halting virtual machine...
==> mysql64-vbox: Preparing to export machine...
    mysql64-vbox: Deleting forwarded port mapping for the communicator (SSH, WinRM, etc) (host port 2425)
==> mysql64-vbox: Exporting virtual machine...
    mysql64-vbox: Executing: export mysql64-vbox --output output-mysql64-vbox/mysql64-vbox.ovf
==> mysql64-vbox: Cleaning up floppy disk...
==> mysql64-vbox: Deregistering and deleting VM...
==> mysql64-vbox: Running post-processor: vagrant
==> mysql64-vbox (vagrant): Creating a dummy Vagrant box to ensure the host system can create one correctly
==> mysql64-vbox (vagrant): Creating Vagrant box for 'virtualbox' provider
    mysql64-vbox (vagrant): Copying from artifact: output-mysql64-vbox/mysql64-vbox-disk001.vmdk
    mysql64-vbox (vagrant): Copying from artifact: output-mysql64-vbox/mysql64-vbox.ovf
    mysql64-vbox (vagrant): Renaming the OVF to box.ovf...
    mysql64-vbox (vagrant): Compressing: Vagrantfile
    mysql64-vbox (vagrant): Compressing: box.ovf
    mysql64-vbox (vagrant): Compressing: metadata.json
    mysql64-vbox (vagrant): Compressing: mysql64-vbox-disk001.vmdk
Build 'mysql64-vbox' finished after 11 minutes 38 seconds.

==> Wait completed after 11 minutes 38 seconds

==> Builds finished. The artifacts of successful builds are:
--> mysql64-vbox: VM files in directory: output-mysql64-vbox
--> mysql64-vbox: 'virtualbox' provider box: mysql64-vbox.box
```

- Add the built image box to Virtualbox

```bash
vagrant box add --force --name mysql64  mysql64-vbox.box
```

Sample result
```bash
➜  packer-mysql64 git:(main) vagrant box add --force --name mysql64  mysql64-vbox.box
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'mysql64' (v0) for provider: 
    box: Unpacking necessary files from: file:///Users/aakulov/Documents/Development/Hashicorp/packer-mysql64/mysql64-vbox.box
==> box: Successfully added box 'mysql64' (v0) for 'virtualbox'!
```

## Publish vagrant box to Vagrant cloud 

- Unlogin from vagrant cloud
```bash
vagrant cloud auth logout 
```

- Login to vagrant cloud
```
vagrant cloud auth login
```

- Create vagrant box record on the Vagrant cloud
```bash
vagrant cloud box create Replace_With_your_vagrant_cloud_account_name/mysql64 --no-private
```
Expected result:
```
Created box Replace_With_your_vagrant_cloud_account_name/mysql64
Box:              Replace_With_your_vagrant_cloud_account_name/mysql64
Description:      
Private:          no
Created:          2021-03-02T09:22:41.029Z
Updated:          2021-03-02T09:22:41.029Z
Current Version:  N/A
Versions:         
Downloads:        0
```
- Publish the local vagrant box image to the Vagrant cloud
Run from the same folder you were before 
```bash
vagrant cloud publish --box-version `date +%y.%m.%d` \
  --force --no-private --release Replace_With_your_vagrant_cloud_account_name/mysql64 \
  `date +%y.%m.%d` virtualbox mysql64-vbox.box 
```
Expected result:
```
You are about to publish a box on Vagrant Cloud with the following options:
aakulov/mysql64:   (v21.03.02) for provider 'virtualbox'
Automatic Release:     true
Saving box information...
Uploading provider with file /Users/aakulov/Documents/Development/Hashicorp/packer-mysql64/mysql64-vbox.box
Releasing box...
Complete! Published Replace_With_your_vagrant_cloud_account_name/mysql64
Box:              Replace_With_your_vagrant_cloud_account_name/mysql64
Description:      
Private:          no
Created:          2021-03-02T09:22:41.029Z
Updated:          2021-03-02T09:23:35.476Z
Current Version:  N/A
Versions:         21.03.02
Downloads:        0

```

## How to use Vagrant box uploaded to Vagrant cloud

- Prepare folder where you store downloaded vagrant boxes
```bash
cd
mkdir my_vagrantboxes_folder
```
Expected result
```bash
$ cd
$ mkdir my_vagrantboxes_folder
$
```

- Change folder to my_vagrantboxes_folder
```
cd my_vagrantboxes_folder
```
Expected result
```bash
$ cd my_vagrantboxes_folder
$
```

- Download vagrant box from Vagrant cloud
```bash
vagrant box add Replace_With_your_vagrant_cloud_account_name/mysql64
```

Example
```bash
$ vagrant box add Replace_With_your_vagrant_cloud_account_name/mysql64
==> box: Loading metadata for box 'Replace_With_your_vagrant_cloud_account_name/mysql64'
    box: URL: https://vagrantcloud.com/Replace_With_your_vagrant_cloud_account_name/mysql64
==> box: Adding box 'Replace_With_your_vagrant_cloud_account_name/mysql64' (v21.03.02) for provider: virtualbox
    box: Downloading: https://vagrantcloud.com/Replace_With_your_vagrant_cloud_account_name/boxes/mysql64/versions/21.03.02/providers/virtualbox.box
Download redirected to host: vagrantcloud-files-production.s3.amazonaws.com
==> box: Successfully added box 'Replace_With_your_vagrant_cloud_account_name/mysql64' (v21.03.02) for 'virtualbox'!
```
