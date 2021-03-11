# Install open-vm-tools so we can mount shared folders
apt-get install -y open-vm-tools

# fix for customization https://kb.vmware.com/s/article/56409
sed -i -e 's/\[Unit\]/\[Unit\]\nAfter=dbus.service/' /lib/systemd/system/open-vm-tools.service
systemctl daemon-reload

# Add /mnt/hgfs so the mount works automatically with Vagrant
mkdir -p /mnt/hgfs

# Cleanup tools iso
rm -f /home/vagrant/linux.iso
