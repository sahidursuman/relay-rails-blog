# Generated by Otto, do not edit manually

variable "infra_id" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "key_name" {}

variable "ami" {}
variable "instance_type" { default = "t2.micro" }
variable "subnet_public" {}
variable "vpc_cidr" {}
variable "vpc_id" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_security_group" "app" {
  name   = "graphql-blog-${var.infra_id}"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_public}"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = ["${aws_security_group.app.id}"]

  tags { Name = "graphql-blog" }
}

output "url" {
  value = "http://${aws_instance.app.public_dns}/"
}
