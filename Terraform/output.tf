
/*  MACHINES PUBLIC_IP OUTPUT */
output "public_machine1" {
  value = "http://${aws_instance.myec2.public_ip}:8080"
}

/* VPC ID OUTPUT */
output "vpcid" {
  value = "${aws_vpc.myvpc.id}"
}


/*  SUBNET ID OUTPUT */
output "public_subnet1_id" {
  value = "${aws_subnet.public_subnet1.id}"
}

/* INTERNET GATEWAY ID OUTPUT */
output "gateway-id" {
  value = "${aws_internet_gateway.my_gateway.id}"
}

/*  ROUTE TABLE ID OUTPUT */
output "public-route-table-id" {
  value = "${aws_route_table.public.id}"
}

/* SECURITY_GROUP ID OUTPUT */
output "security-group-id" {
  value = "${aws_security_group.mysg.id}"
}





