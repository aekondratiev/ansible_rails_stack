# This project follows semantic versioning.

0.3.0
	- Reformat roles to meet Galaxy syntax.
	- Rewrite logstash-forwarder role to build and package the rpm locally.  Reason for this change: the link to the rpm package that the role relied on is no longer valid.  
	- Add create role and create database to postgreSQL.
	- Add configuration and client authentication to postgresql to enable remote connections.
	- Add nodejs role to provide js runtime for rails apps