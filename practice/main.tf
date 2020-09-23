provider "aws" {
  region = "${var.region}"
}

resource "aws_security_group" "allow_web_ssh_traffic" {
  name        = "allow_web_ssh"
  description = "Allow web and ssh inbound traffic"

  ingress {
    description = "web traffic from instance"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "web traffic from instance"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port = 8
  to_port = 0
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh traffic from instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_ssh_traffic_sg"
  }
}


resource "aws_instance" "my_ubuntu" {
  ami = "${var.ec2_ami}"
  instance_type = "${var.type}"
  security_groups = [aws_security_group.allow_web_ssh_traffic.name]
  key_name = "main-key"
  user_data = "${file("install_apache.sh")}"
  tags = {
    Name = "My-Ubutnu-Server"
  }
}
