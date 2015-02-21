<title>Changelog</title>
<h3>This project follows semantic versioning.</h3>

<h2>0.3.0</h2>
<ul>
	<li>Reformat roles to meet Galaxy syntax.</li>
	<li>Rewrite logstash-forwarder role to build and package the rpm locally.  Reason for this change: the link to the rpm package that the role relied on is no longer valid.</li>
	<li>Add create role and create database to postgreSQL.</li>
	<li>Add configuration and client authentication to postgresql to enable remote connections.</li>
	<li>Add nodejs role to provide runtime for rails apps.</li>
	<li>Add net-tools package to common role.  Not a dependency, just useful.</li>
</ul>