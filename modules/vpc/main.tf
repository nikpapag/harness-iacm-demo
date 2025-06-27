
# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------

resource "aws_vpc" "harness_iacm_vpc" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_hostnames = true

    tags = {
        name  = "${var.name}"
        owner = "${var.tag_owner}"
        Name        = "${var.name}"
        Environment = "${var.environment}"
        cost_center = "${var.cost_center}"
        Owner       = "${var.tag_owner}"
        Project     = "${var.project}"
        Terraform   = "true"
    }
}
