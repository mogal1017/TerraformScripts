#sample terraform code for launch ec2 instance

#Mention who is provide like current provider is aws you can mention azure, gcp and others

provider "aws" {
    region = "us-east-1"
}

#security_group
resource "aws_security_group" "terra_sg"{
name = "terra instance sg"
description = "this is securiy group for terraform instance"

#ingress is nothing but the inbound rule for your instance
ingress {

 from_port = 22
 to_port   = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}

#same for http https ports

ingress {
 from_port = 80
 to_port   = 80
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}
}
#provide resource in a block (resource block) which you want to provision or create

resource "aws_instance" "Terr1_instance" {
ami = "ami-05548f9cecf47b442"
instance_type = "t2.micro"
availability_zone = "us-east-1a"
}
