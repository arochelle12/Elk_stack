# Elk_stack
Cloud monitoring via ELK stack

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![alt text](https://github.com/arochelle12/Elk_stack/blob/main/Images/Elk-Stack-Diagram.png "Elk Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above, or alternatively, select portions of the playbook files may be used to install only certain pieces of it, such as Filebeat.

[Elk Stack Files](https://github.com/arochelle12/Elk_stack/tree/main/Ansible)


This document contains the following details:

> Description of the Topology
>   
> Access Policies
> 
> ELK Configuration 
> 
>> Beats in Use
>
>> Machines Being Monitored
>
> How to Use the Playbooks


***
## DESCRIPTION OF TOPOLOGY
The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application is redundant and will be highly available, in addition to balancing traffic to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the operating system, services, and system logs.

The configuration details of each machine may be found below. 

| Name     | Function            | IP Address              | Operating System     |
|----------|---------------------|-------------------------|----------------------|
| Jump Box | Gateway             | ```10.1.0.4``` ```40.88.14.131```   | Linux Ubuntu 18.04.1 |
| Web-1    | Web server for DVWA | ```10.1.0.5```                | Linux Ubuntu 18.04.1 |
| Web-2    | Web server for DVWA | ```10.1.0.7```                | Linux Ubuntu 18.04.1 |
| Elk      | ELK Stack           | ```10.0.0.4``` ```52.229.98.13```   | Linux Ubuntu 18.04.1 |


***
## ACCESS POLOCIES
On the Red Team VNet, only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
```
[my-public-IP]
```

Machines within this network can only be accessed by the Jump Box.
```
40.88.14.131
```

On the ELK VNet, the ELK machine can accept connections from the Internet through port 5601. Access to this machine is only allowed from the following IP addresses:
```
[my-public-IP]
```

All access is secured through security group rules and the use of ssh keys. A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | ```[my-public-IP]```       |
| Web-1    | No                  | ```10.1.0.4```             |
| Web-2    | No                  | ```10.1.0.4```             |
| Elk      | Yes                 | ```[my-public-IP]```       |
		
		
***		
## ELK CONFIGURATION
Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it drastically reduces the potential for human error and it makes it easier to configure multiple machines at once.

[Elk Playbook](https://github.com/arochelle12/Elk_stack/blob/main/Ansible/install-elk.yml)

The playbook implements the following tasks:

>	Configures the ELK container to use more memory
 >
 >	Installs the apt package for Docker
>
 >	Installs the apt package for Python
 >
 >	Installs the Python library for the Docker Engine 
 >
 >	Downloads the Docker container image for ELK and allows it to run on ports 5601, 9200, and 5044
 >
 >	Starts the container and enables the docker service on boot

 

***
## TARGET MACHINES & BEATS
This ELK server is configured to monitor the following machines:
```
10.1.0.5
```
```
10.1.0.7
```

We have installed the following Beats on these machines:

>	Filebeats
>
>	Metricbeats

These Beats allow us to collect the following information from each machine:

>	Filebeats is able to forward and centralize logs and files, this allows us to monitor who is visiting our web servers
>
>	Metricbeats is able to send system and service statistics, this allows us to track when our container resources are being used the most


***
## USING THE PLAYBOOKS
In order to use the playbooks, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

To implement the **Elk playbook**, SSH into the control node and follow the steps below:

1. Copy the ```install-elk.yml``` file to ```/etc/ansible/install-elk.yml```

2. Update the ```/etc/ansible/hosts``` file to include a new group ```[elk]``` with the following machine: ```10.0.0.4 ansible_python_interpreter=/usr/bin/python3```

3. Run the playbook, and after it completes run ```docker ps``` to check that the container is running. 
4. Navigate to ```http://10.0.0.4:5601/app/kibana``` and click "Check Data" to check that the installation worked as expected.

The following screenshot displays the result of running ```docker ps``` after successfully configuring the ELK instance.

![alt text](https://github.com/arochelle12/Elk_stack/blob/main/Images/docker_ps_elk.png "docker ps")

---
To implement the **Filebeat playbook**, SSH into the control node follow the steps below:

1. Create a Filebeat configuration file by running ```curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml```
2. Copy the ```filebeat-config.yml``` file to ```/etc/ansible/files/filebeat-config.yml```

3. Update the ```filebeat-config.yml``` file to include at line #1106 ```output.elasticsearch``` as hosts: ```["10.0.0.4:9200"]``` with username: ```"elastic"``` and password ```"changeme"```, and at line #1806 ```setup.kibana``` as hosts: ```"10.0.0.4:5601"```
4. Copy the ```filebeat-playbook.yml``` file to ```/etc/ansible/roles/filebeat-playbook.yml```

4. Run the playbook.
5. Navigate to ```http://10.0.0.4:5601/app/kibana``` and click "Check Data", then scroll to the bottom of the page and click "Verify Incoming Data" to check that the installation worked as expected.
---
To implement the **Metricbeat playbook**, SSH into the control node follow the steps below:

1. Create a Metricbeat configuration file by running ```curl https://https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat > /etc/ansible/metricbeat-config.yml```
2. Copy the ```metricbeat-config.yml``` file to ```/etc/ansible/files/metricbeat-config.yml```

3. Update the ```metricbeat-config.yml``` file under Kibana ```setup.kibana``` as hosts: ```"10.0.0.4:5601"```, and under Elasticsearch output ```output.elasticsearch``` as hosts: ```["10.0.0.4:9200"]``` with username: ```"elastic"``` and password ```"changeme"```
4. Copy the ```metricbeat-playbook.yml``` file to ```/etc/ansible/roles/metricbeat-playbook.yml```

4. Run the playbook.
5. Navigate to ```http://10.0.0.4:5601/app/kibana``` and click "Check Data" to check that the installation worked as expected.
