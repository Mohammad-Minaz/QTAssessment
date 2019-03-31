provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region = "${var.myregion}"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.10.0.0/16"
    tags  = {
        name = "myvpc"
    }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = "${aws_vpc.myvpc.id}"
  cidr_block = "10.10.0.0/24"
  availability_zone = "us-west-2a"
  tags = {
      name = "public_subnet1"
  }
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = "${aws_vpc.myvpc.id}"
  tags = {
      name = "my_gateway"
  }
}


resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.myvpc.id}"
  tags = {
      name = "public"
  }
  route = {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.my_gateway.id}"
  }
}

resource "aws_route_table_association" "asociation1" {
  subnet_id = "${aws_subnet.public_subnet1.id}"
  route_table_id = "${aws_route_table.public.id}"
  
}
resource "aws_security_group" "mysg" {
  vpc_id = "${aws_vpc.myvpc.id}"
  name = "mysg"
  ingress = {
      from_port = "22"
      to_port = "22"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
   ingress = {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
   egress = {
     from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]  
   }
}

resource "aws_instance" "myec2" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "menu"
  vpc_security_group_ids = ["${aws_security_group.mysg.id}"]
  subnet_id = "${aws_subnet.public_subnet1.id}"
  associate_public_ip_address = true

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("./menu.pem")}"
  }

   provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh",
      "sudo usermod -aG docker ubuntu",
      "sudo docker run -d --name shopizer --rm -p 8080:8080 -it shopizerecomm/shopizer:2.4.0",
    ]
  }
}







