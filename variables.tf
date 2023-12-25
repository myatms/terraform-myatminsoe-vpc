variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "ap-southeast-1"
  
}

#VPC CIDR
variable "vpc-cidr" {
  description = "VPC CIDR"
  type = string
  
}

#Subnet CIDR
variable "public-subnet-cidr" {
  description = "Public subnet CIDR"
  type = string
  
}
