output "public_subnet_1" {
    value = "${aws_subnet.public_subnet_1.id}"
}

output "public_subnet_2" {
    value = "${aws_subnet.public_subnet_2.id}"
}
output "public_subnet_3" {
    value = "${aws_subnet.public_subnet_3.id}"
}

output "private_subnet_1" {
    value = "${aws_subnet.private_subnet_1.id}"
}

output "private_subnet_2" {
    value = "${aws_subnet.private_subnet_2.id}"
}

output "private_subnet_3" {
    value = "${aws_subnet.private_subnet_3.id}"
}

output "eks_security_group" {
    value = "${aws_security_group.eks_nodes.id}"
}
