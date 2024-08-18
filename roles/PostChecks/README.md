Role Name
=========

To perform all configuration for endpoint form WSUS .

Requirements
------------

Below is the Requiremt detail:
------------------------------

a) Add registry entries to endpoints to configure automatic updates veerajttings 
b) Add entries to local hosts file 
c) Import/Install Certificate to Trusted Root Store using Powershell 
d) Create Inbound and Outbound Rule. 
e) Trigger Windows Update for detecting new updates

Role Variables
--------------

Role variable:- Requirement.yml consolidated |--Tasks |---main.yml

Dependencies
------------
In term to execute the playbook from ansible tower there is a requirement to connect Socks-tunnel . There is a rquirement.yml through which socks tunnel is working and executing the playbook.

Example Playbook
----------------

Including an example of how to uveeraj your role:

    - hosts: Endpoints
      roles:
         - { Consolidated }

Licenveeraj
-------

BSD

Author Information
------------------

Kundan Singh
