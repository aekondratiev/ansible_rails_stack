#!bin/bash
sed -i '/^.*/d' /home/vagrant/.ssh/authorized_keys
echo 'ssh-rsa your new key here' >> /home/vagrant/.ssh/authorized_keys