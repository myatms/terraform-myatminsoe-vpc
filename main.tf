
#VPC
resource "aws_vpc" "mylab_vpc" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true
  tags = {
    "Name" = "MyLabsVPC"
  }
}

#Subnet_1
resource "aws_subnet" "mylab_subnet_public" {
  vpc_id                  = aws_vpc.mylab_vpc.id
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  cidr_block              = var.public-subnet-cidr
  tags = {
    "Name" = "Public_Subnet"
  }
}

#IGW
resource "aws_internet_gateway" "mylab-igw" {
  vpc_id = aws_vpc.mylab_vpc.id
}

#Route_Table
resource "aws_route_table" "mylab_pub_rt" {
  vpc_id = aws_vpc.mylab_vpc.id
}

#Route in route table for internet access
resource "aws_route" "mylab_public_route" {
  route_table_id         = aws_route_table.mylab_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mylab-igw.id

}

#Subnet Association
resource "aws_route_table_association" "mylab-rt-associate" {
  route_table_id = aws_route_table.mylab_pub_rt.id
  subnet_id      = aws_subnet.mylab_subnet_public.id


}

#Security Group
resource "aws_security_group" "mylab_sg" {
  name        = "MyLab SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.mylab_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "MyLab SG"
  }
}