<h1>Rails Development Stack 0.1.0</h1>
<h4>In the box:</h4>
<ul>
<li>CentOS 6.6 x86_64</li>
<li>PostgreSQL 9.4</li>
<li>Nginx</li>
<li>Ruby 2.2.0p0</li>
<li>Gem 2.4.5</li>
<li>Rails 4.2</li>
<li>Elasticsearch 1.1.1</li>
<li>Logstash 1.4.2</li>
<li>Kibana 3.0.1</li>
</ul>

<p>This is an in-progress Rails development environment I'm building with Vagrant/Ansible.  Below are my notes from setting up this project and the manual instructions if you were building this at the command line.  I used CentOS 6.6 as my base but the ansible roles work with CentOS 7 too.</p>

<p>Iteration-1: Create roles to congifure each VM--Finished</p>
<p>Iteration-2: Add individual users; configure web/app and db servers --In progress</p>

<p>I'll keep a top level "To Do" list in this section and additional topic-specific lists in each section below.</p>

<h4>To Do:</h4>
<ul>
</ul>

<h2>The Plan</h2>
VMs (3): web/app server, db server, and monitoring service.

<h3>Initial Setup:</h3>
<ul>
	<li>1.  Vagrantfile with 3 machines configured on the same private network.  Grab the base box from Atlas if using Vagrant: mjp182/CentOS_6.6</li>
	<li>2.  Provisioned with Ansible 1.8.2</li>
	<li>3. Create an "ansible.cfg" file.  (You can grab the most recent config file here: https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg)</li>
</ul>

<h3>Create your playbooks</h3>
<p>Plan:  We are going to create playbooks for a Rails/Nginx server, a PostgreSQL server, and an ELK monitoring server.</p>

<h2>Configure Packages Common to All Nodes</h2>
<p>Plan: Install the packages that every node will use.</p>

<p>1.  Install libselinux-python to enable Ansible's file/copy/template related functions.</p>
<p>$ sudo yum install -y libselinux-python</p>

<h2>Configure Nginx</h2>
<p>Plan: We will need to enable the EPEL repo; download Nginx; create a config file; set firewall settings (if necessary); and start the Nginx service.</p>
<ol>
<li>Enable EPEL repository.</li>
<p>Download the EPEL repo for CentOS 6 or 7 with the following command:</p>
<p>$ sudo yum install epel-release -y</p>
<li>Install Nginx package:</li>
<p>$ sudo yum install Nginx -y</p>
<li>Start the Nginx service</li>
<p>$ sudo chkconfig Nginx on # for CentOS6</p>
<p>$ sudo systemctl start Nginx # for CentOS7</p>
</p>
</ol>

<h4>TO DO:</h4>
<p><ul>
</ul>
</p>

<h2>Configure PostgreSQL 9.4 Server and Client Roles</h2>
<p>Plan: We will need to install ansible dependencies so we can talk to PG nodes; enable the PostgreSQL ("PG") repo; download the correct packages; configure the database.  We will also need to install PG packages on the db and client servers.
</p>
<h4>Part 1: Install PG Server</h4>
<ol>
<li>Install pre-reqs:</li>
<p>$ sudo yum install -y python-psycopg2 #Ansible needs this to talk to PG
</p>
<li>Enable PG repo:</li>
<p>$ sudo yum install -y http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
</p>
<li>Grab the necessary packages:</li>
<p>$ sudo yum install -y postgresql94-libs postgresql94 postgresql94-server postgresql94-contrib</p>

<li>Initialize the database cluster:</li>
<p>$ sudo service postgresql-9.4 initdb</p>

<h4>Part 2: Install PG on Client</h4>
<li>Create client role by repeating steps 1-3 with the following packages in step 3:</li>
<p>$ sudo yum install -y postgresql94-libs postgresql94</p>

<h4>To Do:</h4>
<ol>
</ol>

<h2>Configure Ruby/Rails</h2>
<h3>Part 1: Ruby</h3>
<p>Plan:  Install Ruby from source; install bundler; set up symlinks and shared ruby library.</p>

<li>Install the prereqs:</li>
<p>$ sudo yum install -y wget git gcc openssl-devel readline-devel zlib-devel libyaml-devel gcc-c++ patch automake libtool bison libffi-devel</p>

<li>Get the latest stable Ruby tarball (2.2.0):</li>
<p>$ wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.gz</p>

<li>Unpack the tarball</li>
<p>$ tar -xzf ruby-2.2.0.tar.gz</p>

<li>Build Ruby</li>
<p>$ ./ruby-2.2.0/configure --enable-shared; make; sudo make install</p>
<p>Installs to "usr/local" by default</p>

<li>Check for gem</li>
<p>$ gem --version # should see 2.4.5</p>

<p>Config gem docs:</p>
<p>$ echo 'gem: --no-rdoc --no-ri' > ~/.gemrc</p>

<li>Change permissions to allow gem downloads(this assumes that the user is in the wheel group)</li>
<p>$ sudo chgrp -R wheel /usr/local/lib/ruby/</p>
<p>$ sudo chmod -R 775 /usr/local/lib/ruby/</p>
<p>$ sudo chgrp -R wheel /usr/local/bin/</p>
<p>$ sudo chmod -R 775 /usr/local/bin/</p>

<p>An alternative method is to create symlinks.  See "ruby_source" role.</p>

<li>Install Bundler gem</li>
<p>$ gem install bundler</p>

<h3>Part 2: Rails</h3>
<p>Plan: Install Rails 4</p>

<h4>To Do:</h4>
<ul>
<li>Add sha256sum to tarball download</li>
</ul>

<h2>Set Up Logstash Server</h2>
<p>Plan: Create an ELK (Elasticsearch, Logstash, Kibana) stack; set up Logstash forwarder on clients.</p>

<h3>Resources</h3>
While building this project I've used the following as references/guides:
<ul>
<li>Official Ansible Docs</li>
<li>#ansible on Freenode</li>
<li>Jeff Geerling, Ansible Galaxy: https://galaxy.ansible.com/list#/roles/470</li>
<li>PG RPM Building Project - Yum Repository Howto: http://yum.postgresql.org/howtoyum.php</li>
<li>Installing PostgreSQL on Red Hat Enterprise Linux / Fedora Core: see PG RPM Building Project</li>
<li>https://fedoraproject.org/wiki/EPEL.</li>
</ul>