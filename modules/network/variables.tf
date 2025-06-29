
variable "cost_center" {
    description = "Cost Center for domain"
}


variable "tag_owner" {
    description = "Department owning the resource"
}

variable "project" {
  description = "project identifier"
}


variable "vpc_id" {
  description = "vpc_id"
}

variable "region" {
  description = "region"
}

variable "public_subnet_1_cidr" {
    default = "10.0.1.0/24"
    description = "CIDR Block for Public Subnet 1"
}

variable "public_subnet_2_cidr" {
    default = "10.0.2.0/24"
    description = "CIDR Block for Public Subnet 2"
}

variable "public_subnet_3_cidr" {
    default = "10.0.5.0/24"
    description = "CIDR Block for Public Subnet 3"
}

variable "private_subnet_1_cidr" {
    default  = "10.0.3.0/24"
    description = "CIDR Block for Private Subnet 1"
}

variable "private_subnet_2_cidr" {
    default = "10.0.4.0/24"
    description = "CIDR Block for Private Subnet 2"
}

variable "private_subnet_3_cidr" {
    default = "10.0.6.0/24"
    description = "CIDR Block for Private Subnet 3"
}

variable "internet_cidr_blocks" {
    default = "0.0.0.0/0"
}

