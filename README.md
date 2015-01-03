<h1>Rails Development Stack</h1>
<h4>In the box:</h4>
<ul>
<li>CentOS 6.6 x86_64</li>
<li>PostgreSQL 9.4</li>
<li>Nginx</li>
<li>Ruby 2.2.0p0</li>
<li>Gem 2.4.5</li>
<li>Rails 4.2</li>
</ul>

<p>This is an in-progress Rails development environment I'm building with Vagrant/Ansible.  Below are all my notes from setting up this project.  A bit of a mess now but the plan is to clean it up once finished.</p>

<p>This is iteration-1.  The goal is to set up each node with the correct software.  Iteration-2 will configure the environment for a single project.  Iteration-3 will create variables and remove hard coding.</p>

<p>I'll keep a general "To Do" list in this section and additional topic-specific lists in each section below.</p>

<h4>To Do:</h4>
<ul>
<li>Find easier way to set up ssh keys for public Vagrant boxes</li>
<li>Update playbooks to use variables in later iteration</li>
<li>Add "update_cache=yes" to playbooks.</li>
<li>Firewall/SElinux settings</li>
<li>Add cleanup</li>
</ul>

<p>Current time to provision: ~25 minutes.</p>
<h2>The Plan</h2>
Using vagrant with the following VMs (3): web/app server, db server, and monitoring service.  I am going to configure everything manually at first and then show how the same would be done with Ansible.

<h3>Initial Setup:</h3>
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

<h2>Configure Packages Common to All Nodes</h2>
<p>Plan: Install the packages that every node will use.</p>

<p>1.  Install libselinux-python to enable Ansible's file/copy/template related functions.</p>
<p>$ sudo yum install -y libselinux-python</p>

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
<h4>TO DO:</h4>
<p><ul>
<li>a. Set up ports, firewall, selinux.</li>
<li>b. index.html is located at "/usr/share/nginx/html"</li>
<li>c. config file "/etc/nginx/nginx.conf"</li>
<li>d. Set user permissions</li>
</ul>
</p>

<h2>Configure PostgreSQL 9.4 Server and Client Roles</h2>
<p>Plan: We will need to install ansible dependencies so we can talk to PG nodes; enable the PostgreSQL ("PG") repo; download the correct packages; configure the database.  We will need to install PG packages on the db and client servers.
</p>
<h4>Part 1: Install PG Server</h4>
<p>1. Install pre-reqs:</p>
<p>
$ sudo yum install -y python-psycopg2 #Ansible needs this to talk to PG
</p>
<p>2. Enable PG repo:</p> 
<p>
$ sudo yum install -y http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
</p>
<p>3. Grab the necessary packages:</p>
<p>
$ sudo yum install -y postgresql94-libs postgresql94 postgresql94-server postgresql94-contrib
</p>
This installed dependencies: I needed libxslt
</p>
<p>4. Initialize the database cluster:</p>
<p>
$ sudo service postgresql-9.4 initdb</p>

<h4>Part 2: Install PG on Client</h4>
<p>5. Create client role by repeating steps 1-3 with the following packages in step 3:</p>
<p>$ sudo yum install -y postgresql94-libs postgresql94</p>

<h4>To Do:</h4>
<ol>
<li>Where is the PGP key?  Don't need it but install throws a warning without it.  If I could find it, would use "$ rpm -import http://link/to/key".  There is no warning when I use "yum install"</li>
</ol>

<h4>Errors:</h4>

<h2>Configure Ruby/Rails</h2>
<h3>Part 1: Ruby</h3>
<p>Plan:  Install Ruby from source; install bundler; set up symlinks and shared ruby library.</p>

<p>1. Install the prereqs:</p>
<p>$ sudo yum install -y wget git gcc openssl-devel readline-devel zlib-devel libyaml-devel gcc-c++ patch automake libtool bison libffi-devel</p>

<p>2. Get the latest stable Ruby tarball (2.2.0):</p>
<p>$ wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.gz</p>

<p>3. Unpack the tarball</p>
<p>$ tar -xzf ruby-2.2.0.tar.gz</p>

<p>4. Build Ruby</p>
<p>$ ./ruby-2.2.0/configure --enable-shared; make; sudo make install</p>
<p>Installs to "usr/local" by default</p>

<p>5. Check for gem</p>
<p>$ gem --version # should see 2.4.5</p>

<p>5a. Config gem docs</p>
<p>$ echo 'gem: --no-rdoc --no-ri' > ~/.gemrc</p>

<p>6. Change permissions to allow gem downloads(this assumes that the user is in the wheel group)</p>
<p>$ sudo chgrp -R wheel /usr/local/lib/ruby/</p>
<p>$ sudo chmod -R 775 /usr/local/lib/ruby/</p>
<p>$ sudo chgrp -R wheel /usr/local/bin/</p>
<p>$ sudo chmod -R 775 /usr/local/bin/</p>

<p>An alternative method is to create symlinks.</p>

<p>7. Install Bundler gem</p>
<p>$ gem install bundler</p>

<h3>Part 2: Rails</h3>
<p>Plan: Install Rails 4</p>

<h4>To Do:</h4>
<ul>
<li>Add sha256sum to tarball download</li>
<li>Install PG client</li>
<li>Should I have a "testrb" dir located in /usr/local/bin/?</li>
</ul>
<h4>Errors</h4>
---Fixed:
<p> Can't install bundler.  Get this error: You don't have write permissions for the /usr/local/lib/ruby/gems/2.2.0 directory.</p>
<p>I change the permissions on that directory with "chmod 777 /dir" to give rwx access to everyone.  Try to install bundler and get a new error: Fetching: bundler-1.7.10.gem (100%)
ERROR:  While executing gem ... (Errno::EACCES)
    Permission denied @ rb_sysopen - /usr/local/lib/ruby/gems/2.2.0/cache/bundler-1.7.10.gem</p>
<p>I change back the original permissions to 755 and change the group ownership from root to wheel "sudo chgrp -R wheel /usr/local/lib/ruby/".  Failed, no write permissions.  Now I will change the permissions to 775 with "sudo chmod -R 775 /usr/local/lib/ruby/".  New error: You don't have write permissions for the /usr/local/bin directory.  So, change the group to wheel and change the permissions to 775:</p>
<p>$ sudo chgrp -R wheel /usr/local/bin/</p>
<p>$ sudo chmod -R 775 /usr/local/bin/</p>

<p>This works and now I can install the bundler gem.  But what new permissions traps await me?  Only time will tell....</p>

<h3>Resources</h3>
While building this project I've used the following as references/guides:
<ul>
<li>Official Ansible Docs</li>
<li>#ansible on Freenode</li>
<li>Jeff Geerling, Ansible Galaxy: https://galaxy.ansible.com/list#/roles/470</li>
<li>PG RPM Building Project - Yum Repository Howto: http://yum.postgresql.org/howtoyum.php</li>
<li>Installing PostgreSQL on Red Hat Enterprise Linux / Fedora Core: see PG RPM Building Project</li>
</ul>