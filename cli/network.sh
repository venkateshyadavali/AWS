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
aws ec2 create-tags --resources rtb-0300a162986101b58 --tags Key=Name,Value=public
