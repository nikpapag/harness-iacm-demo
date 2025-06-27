variable "name" {
  description = "Name prefix for all resources"
  type        = string
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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
