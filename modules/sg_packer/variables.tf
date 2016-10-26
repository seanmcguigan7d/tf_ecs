// Module specific variables

variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "out_source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}

variable "inc_source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}


