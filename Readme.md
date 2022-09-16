The Task is to create a network architecture showing the network components necessary to invoke a Lambda running in a
Virtual Private Cloud (VPC) in the us-east-1 region. The design should follow networking and AWS best practices

This Readme is a bit explanation to what steps were considered in setting up this architecture from the AWS GUI. Thus the naming convention may not aligned with the names used in the Tf files. 
Also, It should be noted that the three 3 methods presented here are
(i) One for exploring the concept of Model which automatically generate the input , output and variables configuration upon running the command terraform init for the model (vpc.tf)
(ii) The Manual Vpc Run takes into consideration the approach of manaully spinning up each of the associated resources if Model is not employed i.e. vpc-manual.tf
(iii) Optionally, A Tf configuration file for launching the Lambda function with the VPC is also showcase i.e. (azure_function_main.tf)



***************High level Step to setup the VPC and its associated resources set up*************************

Step-01: Introduction
Create VPC
Create Public and Private Subnets
Create Internet Gateway and Associate to VPC
Create NAT Gateway in Public Subnet
Create Public Route Table, Add Public Route via Internet Gateway and Associate Public Subnet
Create Private Route Table, Add Private Route via NAT Gateway and Associate Private Subnet


Step-02: Create VPC
Name: my-manual-vpc
IPv4 CIDR Block: 10.10.0.0/22
Rest all defaults


Step-03: Create Subnets

Step-03-01: Public Subnet
VPC ID: my-manual-vpc
Subnet Name:: my-public-subnet-1
Availability zone: us-east-1a
IPv4 CIDR Block: 10.10.101.0/24

Step-03-02: Private Subnet
Subnet Name:: my-private-subnet-1
Availability zone: us-east-1a
IPv4 CIDR Block: 10.10.1.0/24



Step-04: Create Internet Gateway and Associate it to VPC
Name Tag: my-igw
Create Internet Gateway
via Actions -> Attach to VPC -> my-manual-vpc


Step-05: Create NAT Gateway
Name: my-nat-gateway
Subnet: my-public-subnet-1
Allocate Elastic Ip: click on that



Step-06: Create Public Route Table and Create Routes and Associate Subnets

Step-06-01: Create Public Route Table
Name tag: my-public-route-table
vpc: my-manual-vpc

Step-06-02: Create Public Route in newly created Route Table (egress rule for puplic subnet)
Click on Add Route
Destination: 0.0.0.0/0
Target: my-igw

Step-06-03: Associate Public Subnet 1 in Route Table
Click on Edit Subnet Associations
Select my-public-subnet-1


Step-07: Create Private Route Table and Create Routes and Associate Subnets

Step-07-01: Create Private Route Table
Name tag: my-private-route-table
vpc: my-manual-vpc


Step-07-02: Create Private Route in newly created Route Table (ingress rule private subnet)
Click on Add Route
Destination: 0.0.0.0/0
Target: my-nat-gateway

Step-07-03: Associate Private Subnet 1 in Route Table
Click on Edit Subnet Associations
Select my-private-subnet-1
