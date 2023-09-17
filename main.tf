provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "webserver" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.sg.name]
    key_name = "tf-webserver"
    tags = {
        Name: "flask-app"
    }
    user_data = file("./env.sh")
      
}

variable "ingress" {
  type        = list(number)
  default     = [80,443,22]
  description = "security group ports"
}

variable "egress" {
  type        = list(number)
  default     = [80,443]
  description = "security group ports"
}

resource "aws_security_group" "sg" {
    name = "Allow web traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"] 
        }
    }

    dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"] 
        }
    }
}
