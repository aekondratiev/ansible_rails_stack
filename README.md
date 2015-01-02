<h1>Rails Deployment</h1>

This is an in-progress Rails development environment I'm building while I learn Ansible.  Below are all my notes from setting up this project.  A bit of a mess now but the plan is to clean it up once finished.

<h2>The Plan</h2>
Using vagrant with the following VMs (3): web/app server, db server, and monitoring service.  I am going to configure everything manually at first and then show how the same would be done with Ansible.

<h3>Steps:</h3>
<ul>
	<li>1.  Create Vagrantfile with 3 machines configured on the same private network.</li>
	<li>2.  Configure Ansible to use the insecure Vagrant ssh keys.  To keep things simple, I created a local .ssh folder and copied the Vagrant insecure keys that ship with public boxes.  I needed to add "config.ssh.insert_key = false" to my Vagrantfile in order to prevent new keys being used on spin up.  </li>
	<li>3.  Create an inventory file called "hosts".  Place each machine in the appropriate group and assign the vagrant user. </li>
	<li>4. Create an "ansible.cfg" file and add the ssh private key path.  (You can grab the most recent config file here: https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg)</li>
	<li>5. Spin up your VMs and test connectivity with "ansible all -m ping".  You should see "success" outputs for each machine. </li>
</ul>

<h3>Create your playbooks</h3>
<p>Plan:  We are going to create playbooks for a Rails/Nginx server, a PostgreSQL server, and a monitoring server (to be named later).  I'll be using the "playbook.yml" file in the root directory to test out my roles as I go along.</p>
<p>1.  Create the file skeleton for your playbooks, roles, tasks, etc.  A "site.yml" file needs to be in the main directory that will reference hosts and roles to apply.</p>
<p>1b.  Create the following roles: common, web, db, monitor.</p>
<p>2.  Create a "roles" folder and then, inside, create folders for each of the roles you reference in site.yml.</p>
<p>3. Create a "main.yml" file inside each role folder.  We will use "includes" inside main.yml but we will create the additional files/folders in later sections.</p>

<h2>Configure Nginx</h2>
<p>Plan: We will need to enable the EPEL repo; download Nginx; create a config file; set firewall settings; and start the Nginx service.</p>

<p>1.  Enable EPEL repository.  https://fedoraproject.org/wiki/EPEL.  

Download the EPEL repo for CentOS 6 or 7 with the following command:
$ sudo yum install epel-release -y
</p>
<p>2.  Install Nginx package:
$ sudo yum install Nginx -y
</p>
<p>3.  Start the Nginx service
$ sudo chkconfig Nginx on # for CentOS6
$ sudo systemctl start Nginx # for CentOS7
</p>
<p>TODO:
a. Set up ports, firewall, selinux.
b. index.html is located at "/usr/share/nginx/html"
c. config file "/etc/nginx/nginx.conf"
d. Set user permissions
</p>
<h2>Configure PostgreSQL Server</h2>
<p>Plan: We
</p>

<h3>Resources</h3>
While building this project I've used the following as references/guides:
<ul>
<li>Official Ansible Docs</li>
<li>#ansible on Freenode</li>
<li>Ansible Galaxy</li>
</ul>