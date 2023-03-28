#Terraform blocks: 9 top level blocks

#1. Terraform setting block:

terraform {
  required_version = "~> 1.0"         #1.1.4/5/6/7   1.2/3/4/5 1.1.4/5/6/7
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-mylandmark"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}

#2. Provider block: plugin /api

provider "aws" {
  #profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-west-2"
}

#3. Resource block:works with move block when an instance change
  resource "aws_instance" "bootcamp31" {
     #ami           = "ami-0e5b6b6a9f3db6db8" # Amazon Linux
     ami = data.aws_ami.ubuntu.id
     instance_type = var.instance_type[1]
     delete_on_termination = true

     tags = {
      Name = local.name
     }
    }

#4. Variables block / inputs

variable "instance_type" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t2.micro", "t2.medium"]
}

 Output blocks

output "public_ip" {
  description = "ec2 instance public ip"
  value = aws_instance.inst1.arn
}

6. local value blocks:

  locals {
    name = "${var.app_name}-${var.environment}"
  }
  jenkins-production

7. Data sources:
   data "aws_ami" "ubuntu" {
     most_recent = true
     owners = ["self"]

     filter {
      name = "name"
      value = ["packer-docker"]
     }
   }

8. Modules block:

  module "ec2" {
    source = "./my_instance"
    version = "1.0.1"

    instance_type = var.instance_type
  }

9. moved blocks

moved {
  from = "aws_instance.bootcamp30 "
  to = "aws_instance.bootcamp31 "
}
