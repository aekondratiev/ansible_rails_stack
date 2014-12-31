<h1>Rails Deployment</h1>

This is a practice go to set up a Rails Development environment using Ansible.

<h2>Set Up</h2>
Using vagrant with the following VMs (4): web server, db server, load balance, monitoring service.

<h3>Steps:</h3>
<ul>
	<li>1.  Create Vagrantfile with 4 machines configured on the same private network.</li>
	<li>2.  Set up SSH keys for Ansible.  To keep things simple, I created a local .ssh folder and copied the Vagrant insecure keys that ship with public boxes.  I needed to add "config.ssh.insert_key = false" to my Vagrantfile in order to prevent new keys being used on spin up.  </li>
	<li>3.  Create an inventory file called "hosts".  Place each machine in the appropriate group and assign the vagrant user. </li>
	<li>4. Create an ansible.cfg file and add your ssh private key path.  (You can grab the most recent config file here: https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg)</li>
	<li>5. Spin up your VMs and test connectivity with "ansible all -m ping".  You should see "success" outputs for each machine. </li>
</ul>

<h3>Create your playbooks</h3>
Plan:
1.  Create the file skeleton for your playbooks, roles, tasks, etc.  A "site.yml" file needs to be in the main directory that will reference hosts and roles to apply.
2.  Create a role, "common" that will apply to all vms (aka, nodes).
3.  What to include?
4.  Create a role, "rails" to set up rails dev environment.
5.  Create a role, "db" to set up a postgreSQL environment.
