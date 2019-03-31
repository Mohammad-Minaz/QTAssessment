# Creating VPC :-
  aws ec2 create-vpc --cidr-block 192.168.0.0/16
#  "VpcId": "vpc-0047897ad36b4d3bf"


# creating public subnet:-
  aws ec2 create-subnet --cidr-block 192.168.0.0/24 --vpc-id vpc-0047897ad36b4d3bf
#  "SubnetId": "subnet-01f4265a3b3825d7a"


# Create Security group
  aws ec2 create-security-group --description Allowall --group-name mysg --vpc-id vpc-0047897ad36b4d3bf
#  "GroupId": "sg-0ebd14961466daa83"

# adding inbound rule to security group
  aws ec2 authorize-security-group-ingress --group-id sg-0ebd14961466daa83 --protocol tcp --port 22 --cidr 0.0.0.0/0
  aws ec2 authorize-security-group-ingress --group-id sg-0ebd14961466daa83 --protocol tcp --port 80 --cidr 0.0.0.0/0


# create route table
  aws ec2 create-route-table --vpc-id vpc-0047897ad36b4d3bf
#  "RouteTableId": "rtb-099761b25a641aeed"


# create internet gatway
  aws ec2 create-internet-gateway
# "InternetGatewayId": "igw-0175116265933c110"


# attach igw to vpc
 aws ec2 attach-internet-gateway --internet-gateway-id igw-0175116265933c110 --vpc-id vpc-0047897ad36b4d3bf


# create route
  aws ec2 create-route --route-table-id rtb-099761b25a641aeed --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0175116265933c110


# associate route table
  aws ec2 associate-route-table --route-table-id rtb-099761b25a641aeed --subnet-id subnet-01f4265a3b3825d7a
# "AssociationId": "rtbassoc-0ef9efa3260f24cc9"


# crreating ec2 instance ubuntu 16 
  aws ec2 run-instances --image-id ami-0565af6e282977273 --instance-type t2.micro --key-name abc --security-group-ids sg-0ebd14961466daa83 --subnet-id subnet-01f4265a3b3825d7a --count 1 --associate-public-ip-address
# "InstanceId": "i-024e41ce98632edf3"


# creating AMI of the above machine 
  aws ec2 create-image --instance-id i-024e41ce98632edf3 --name shopizer
# "ImageId": "ami-0d074eebc8bd1c144"


# Creating AWS CLI script to create VM using the image created in earlier step
   aws ec2 run-instances --image-id ami-0d074eebc8bd1c144 --instance-type t2.micro --key-name abc --security-group-ids sg-0ebd14961466daa83 --subnet-id subnet-01f4265a3b3825d7a --count 1 --associate-public-ip-address
# "InstanceId": "i-094f6843abcafa53a"

======================================================================================================================================================================================================================================
