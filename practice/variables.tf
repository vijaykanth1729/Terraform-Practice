variable "region" {
  description = "region for ur instance"
  default = "us-east-1"
}

variable "ec2_ami" {
  default = "ami-0dba2cb6798deb6d8"
}

variable "type" {
  default = "t2.micro"
}
