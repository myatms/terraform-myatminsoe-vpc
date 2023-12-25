variable "aws_region" {
  description = "The Region of AWS"
  type        = string

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
