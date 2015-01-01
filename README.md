<h1>Rails Deployment</h1>

This is a practice go to set up a Rails Development environment using Ansible.

<h2>Set Up</h2>
Using vagrant with the following VMs (3): web/app server, db server, and monitoring service.

<h3>Steps:</h3>
<ul>
	<li>1.  Create Vagrantfile with 4 machines configured on the same private network.</li>
	<li>2.  Set up SSH keys for Ansible.  To keep things simple, I created a local .ssh folder and copied the Vagrant insecure keys that ship with public boxes.  I needed to add "config.ssh.insert_key = false" to my Vagrantfile in order to prevent new keys being used on spin up.  </li>
	<li>3.  Create an inventory file called "hosts".  Place each machine in the appropriate group and assign the vagrant user. </li>
	<li>4. Create an ansible.cfg file and add your ssh private key path.  (You can grab the most recent config file here: https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg)</li>
	<li>5. Spin up your VMs and test connectivity with "ansible all -m ping".  You should see "success" outputs for each machine. </li>
</ul>

<h3>Create your playbooks</h3>
Plan:  We are going to create playbooks for a Rails/Nginx server, a PostgreSQL server, and a monitoring server (to be named later).
NOTE: If you like to test as you go along you can only include roles that have been finished.
1.  Create the file skeleton for your playbooks, roles, tasks, etc.  A "site.yml" file needs to be in the main directory that will reference hosts and roles to apply.
1b.  Create the following roles: common, web, db, monitor.
2.  Create a "roles" folder and then, inside, create folders for each of the roles you reference in site.yml.
3. Create a main.yml file inside each role folder.  We will use includes inside main.yml but we will create the additional files/folders in later sections.

<h2>Configure Nginx</h2>
We will need to enable the EPEL repo; download Nginx; create a config file; and start the Nginx service.

1.  Enable EPEL repository.  https://fedoraproject.org/wiki/EPEL.  First, we do it manually.  Then we convert it to ansible syntax.

Download the EPEL repo for CentOS 6 or 7 with the following command:
$ sudo yum install epel-release -y

2.  Install Nginx package:
$ sudo yum install Nginx -y

3.  Start the Nginx service
$ sudo chkconfig Nginx on # for CentOS6
$ sudo systemctl start Nginx # for CentOS7

TODO:
Set up ports, firewall, selinux.

<h2>Configure PostgreSQL</h2>
We 