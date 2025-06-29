
variable "vpc_id" {
  description = "vpc_id"
}

variable "region" {
  description = "region"
}

variable "eks_cluster_name" {
  description = "region"
}

variable "private_subnet_1" {
  description = "private subnet"
}

variable "private_subnet_2" {
  description = "private subnet"
}

variable "private_subnet_3" {
  description = "private subnet"
}

variable "instance_type" {
  description = "node pool instance type"
  default = "t3.medium"
}

variable "environment" {
    description = "env"
    type        = string
}

variable "cost_center" {
    description = "Cost Center for domain"
}


variable "tag_owner" {
    description = "Department owning the resource"
}

variable "project" {
  description = "project identifier"
}

variable "security_group" {
  description = "Security Group for the eks cluster"
}
