#sample terraform code for launch ec2 instance

#Mention who is provide like current provider is aws you can mention azure, gcp and others

provider "aws" {
    region = "us-east-1"
}

#provide resource in a block (resource block) which you want to provision or create

resource "aws_instance" "Terr_instance" {
ami = "ami-05548f9cecf47b442"
instance_type = "t2.micro"
availability_zone = "us-east-1a"
}
