
resource "aws_subnet" "public_subnet_1" {
  cidr_block        = "${var.public_subnet_1_cidr}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}a"

  tags = {
    name  = "public_${var.project}_subnet_1"
    cost_center = "${var.cost_center}"
    owner = "${var.tag_owner}"
    "kubernetes.io/role/elb" = "1"
  }
}


resource "aws_subnet" "public_subnet_2" {
  cidr_block        = "${var.public_subnet_2_cidr}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}b"

  tags = {
    name  = "public_${var.project}_subnet_2"
    cost_center = "${var.cost_center}"
    owner = "${var.tag_owner}"
    "kubernetes.io/role/elb" = "1"
  }
}


resource "aws_subnet" "public_subnet_3" {
  cidr_block        = "${var.public_subnet_3_cidr}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.region}c"

  tags = {
    name  = "public_${var.project}_subnet_3"
    cost_center = "${var.cost_center}"
    owner = "${var.tag_owner}"
    "kubernetes.io/role/elb" = "1"
  }
}


resource "aws_subnet" "private_subnet_1" {
    cidr_block        = "${var.private_subnet_1_cidr}"
    vpc_id            = "${var.vpc_id}"
    availability_zone = "${var.region}a"

    tags = {
        name  = "private_${var.project}_subnet_1"
        cost_center = "${var.cost_center}"
        owner = "${var.tag_owner}"
        "kubernetes.io/role/internal-elb" = "1"
    }
}

resource "aws_subnet" "private_subnet_2" {
    cidr_block        = "${var.private_subnet_2_cidr}"
    vpc_id            = "${var.vpc_id}"
    availability_zone = "${var.region}b"

    tags = {
        name  = "private_${var.project}_subnet_2"
        cost_center = "${var.cost_center}"
        owner = "${var.tag_owner}"
        "kubernetes.io/role/internal-elb" = "1"
    }
}



resource "aws_subnet" "private_subnet_3" {
    cidr_block        = "${var.private_eks_subnet_3_cidr}"
    vpc_id            = "${var.vpc_id}"
    availability_zone = "${var.region}c"

    tags = {
        name  = "private_${var.project}_subnet_3"
        cost_center = "${var.cost_center}"
        owner = "${var.tag_owner}"
        "kubernetes.io/role/internal-elb" = "1"
    }
}


resource "aws_route_table" "public_route_table" {
    vpc_id  = "${var.vpc_id}"

    tags = {
        name  = "${var.project}_prod_public_route"
        cost_center = "${var.cost_center}"
        owner = "${var.tag_owner}"
    }
}


resource "aws_route_table" "private_route_table" {
    vpc_id  = "${var.vpc_id}"

    tags = {
        name  = "${var.project}_prod_private_route"
        cost_center = "${var.cost_center}"
        owner = "${var.tag_owner}"
    }
}


resource "aws_route_table_association" "public_route_table_1_association"{
    route_table_id = "${aws_route_table.public_route_table.id}"
    subnet_id      = "${aws_subnet.public_subnet_1.id}"
}
resource "aws_route_table_association" "public_route_table_2_association"{
    route_table_id = "${aws_route_table.public_route_table.id}"
    subnet_id      = "${aws_subnet.public_subnet_2.id}"
}
resource "aws_route_table_association" "public_route_table_3_association"{
    route_table_id = "${aws_route_table.public_route_table.id}"
    subnet_id      = "${aws_subnet.public_subnet_3.id}"
}


resource "aws_route_table_association" "private_route_table_1_association"{
    route_table_id = "${aws_route_table.private_route_table.id}"
    subnet_id      = "${aws_subnet.private_subnet_1.id}"
}


resource "aws_route_table_association" "private_route_table_2_association"{
    route_table_id = "${aws_route_table.private_route_table.id}"
    subnet_id      =  "${aws_subnet.private_subnet_2.id}"
}

resource "aws_route_table_association" "private_route_table_3_association"{
    route_table_id = "${aws_route_table.private_route_table.id}"
    subnet_id      = "${aws_subnet.private_subnet_3.id}"
}


resource "aws_eip" "elastic_ip_for_nat_gw" {
    associate_with_private_ip = "10.0.0.5"

    tags = {
        name  = "${var.project}"
        owner = "${var.tag_owner}"
    }
}


resource "aws_nat_gateway" "nat_gw" {
    allocation_id = "${aws_eip.elastic_ip_for_nat_gw.id}"
    subnet_id     = "${aws_subnet.public_subnet_1.id}"
    tags = {
            name  = "${var.project}_nat_gw"
            owner = "${var.tag_owner}"
    }
    depends_on = [ aws_eip.elastic_ip_for_nat_gw ]
}

#Allow outbound traffic from private resources
resource "aws_route" "nat_gw_route" {
    route_table_id          = "${aws_route_table.private_route_table.id}"
    nat_gateway_id          = "${aws_nat_gateway.nat_gw.id}"
    destination_cidr_block  = "0.0.0.0/0"
}


resource "aws_internet_gateway" "production_igw" {
    vpc_id = "${var.vpc_id}"

    tags = {
        name  = "${var.project}_internet_gateway"
        owner = "${var.tag_owner}"
    }
}


resource "aws_route" "public_internet_gw_route" {
    route_table_id         = "${aws_route_table.public_route_table.id}"
    gateway_id             = "${aws_internet_gateway.production_igw.id}"
    destination_cidr_block = "0.0.0.0/0"
}


resource "aws_security_group" "alb_security_group" {
    name = "${var.project}_alb_sg"
    description = "security group for eks cluster"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port   = 80
        protocol    = "TCP"
        to_port     = 80
        cidr_blocks = ["${var.internet_cidr_blocks}"]
    }


    ingress {
        from_port   = 8080
        protocol    = "TCP"
        to_port     = 8080
        cidr_blocks = ["${var.internet_cidr_blocks}"]
    }

    ingress {
        from_port   = 8085
        protocol    = "TCP"
        to_port     = 8090
        cidr_blocks = ["${var.internet_cidr_blocks}"]
    }

    ingress {
        from_port   = 8090
        protocol    = "TCP"
        to_port     = 8090
        cidr_blocks = ["${var.internet_cidr_blocks}"]
    }

    egress {
        from_port   = 0
        protocol    = "-1"
        to_port     = 0
        cidr_blocks = ["${var.internet_cidr_blocks}"]
    }

}

output "eks_security_group" {
    value = "${aws_security_group.alb_security_group.id}"
}



# Security group for EKS nodes
resource "aws_security_group" "eks_nodes" {
  vpc_id = "${var.vpc_id}"

  # Allow outbound internet traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}