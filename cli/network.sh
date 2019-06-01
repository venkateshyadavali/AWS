## Create a VPC with CIDR 10.10.0.0/16
aws ec2 create-vpc --cidr-block 10.10.0.0/16
# VpcId: vpc-014cade991b55f2bf

# To add tag to VPC
aws ec2 create-tags --resources vpc-014cade991b55f2bf --tags Key=Name,Value=ntier

# To Delete VPC
aws ec2 delete-vpc --vpc-id vpc-014cade991b55f2bf

#---------------------------------------------------

## Create 4 subnets under above VPC with subnet ranges 10.10.0.0/24, 10.10.1.0/24, 10.10.2.0/24 and 10.10.3.0/24
aws ec2 create-subnet --vpc-id vpc-014cade991b55f2bf --cidr-block 10.10.0.0/24 --availability-zone us-west-2a
aws ec2 create-subnet --vpc-id vpc-014cade991b55f2bf --cidr-block 10.10.1.0/24 --availability-zone us-west-2b
aws ec2 create-subnet --vpc-id vpc-014cade991b55f2bf --cidr-block 10.10.2.0/24 --availability-zone us-west-2c
aws ec2 create-subnet --vpc-id vpc-014cade991b55f2bf --cidr-block 10.10.3.0/24 --availability-zone us-west-2a

# Add tags to created subnets
aws ec2 create-tags --resources subnet-04b1f626a27c24cdb --tags Key=Name,Value=web
aws ec2 create-tags --resources subnet-0ca3b0d5553b108e2 --tags Key=Name,Value=business
aws ec2 create-tags --resources subnet-05c6a4a081f81c296 --tags Key=Name,Value=data
aws ec2 create-tags --resources subnet-0ef02aa2334760214 --tags Key=Name,Value=management

# To Delete subnet
aws ec2 delete-subnet --subnet-id <subnet-id>

#---------------------------------------------------

## Create internet gateway and assign to the create VPC
# 1. Create internet gateway
aws ec2 create-internet-gateway
	# InternetGatewayId: igw-02ea0c3e681d3c7be
# 2. Attach the igw to the required VPC
aws ec2 attach-internet-gateway --internet-gateway-id igw-02ea0c3e681d3c7be --vpc-id vpc-014cade991b55f2bf

# Add tag to internet gateway
aws ec2 create-tags --resources igw-02ea0c3e681d3c7be --tags Key=Name,Value=ntier-igw

#---------------------------------------------------

## Create a Route Table and establish it the VPC, add routes
# 1. Create Route Table
aws ec2 create-route-table --vpc-id vpc-014cade991b55f2bf

# RouteTableId": "rtb-0300a162986101b58

# 2. Add 
aws ec2 create-route --route-table-id rtb-0300a162986101b58 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-02ea0c3e681d3c7be

# Add tag to route table
# Since this route table is connected to internet gateway, this would be public route table
aws ec2 create-tags --resources rtb-0300a162986101b58 --tags Key=Name,Value=public

# Add two subnets (web, management) to this public Route Table (associate-route-table)
aws ec2 associate-route-table --route-table-id rtb-0300a162986101b58 --subnet-id subnet-04b1f626a27c24cdb
    #"AssociationId": "rtbassoc-05535bd85b36c9b4a"
aws ec2 associate-route-table --route-table-id rtb-0300a162986101b58 --subnet-id subnet-0ca3b0d5553b108e2
    #"AssociationId": "rtbassoc-05ed3f5f11c771320"


#--------------
# Create another Route Table for Private
aws ec2 create-route-table --vpc-id vpc-014cade991b55f2bf
        #"RouteTableId": "rtb-0cbd259c8b01e29c5",

# Add tag to the route table as private
aws ec2 create-tags --resources rtb-0cbd259c8b01e29c5 --tags Key=Name,Value=private

# Add two subnets (web, management) to this private Route Table (associate-route-table)
aws ec2 associate-route-table --route-table-id rtb-0cbd259c8b01e29c5 --subnet-id subnet-05c6a4a081f81c296
    #"AssociationId": "rtbassoc-03a6da9dba05c8a39"
aws ec2 associate-route-table --route-table-id rtb-0cbd259c8b01e29c5 --subnet-id subnet-0ef02aa2334760214
    #"AssociationId": "rtbassoc-0a651622addbc5c45"


#aws ec2 replace-route-table-association --association-id rtbassoc-0a651622addbc5c45 --route-table-id rtb-0cbd259c8b01e29c5
#    "NewAssociationId": "rtbassoc-0a651622addbc5c45"


#---------------------------------------------------
# Create Security Group
aws ec2 create-security-group --group-name allowsshhttp --description "Allow ssh, http and https" --vpc-id vpc-014cade991b55f2bf 
	#"GroupId": "sg-041d57332c58f5442"

# Add Inbound rules
# authorize-security-group-ingress
aws ec2 authorize-security-group-ingress --group-id "sg-041d57332c58f5442" --protocol "tcp" --cidr "0.0.0.0/0" --port "22"
aws ec2 authorize-security-group-ingress --group-id "sg-041d57332c58f5442" --protocol "tcp" --cidr "0.0.0.0/0" --port "80"
aws ec2 authorize-security-group-ingress --group-id "sg-041d57332c58f5442" --protocol "tcp" --cidr "0.0.0.0/0" --port "443"

# Adding same above ingres security group rules in one line

#---------------------------------------------------
#Create a EC2 machine

