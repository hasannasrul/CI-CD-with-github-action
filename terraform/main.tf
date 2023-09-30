provider "aws" {
    region = "us-east-1"
}
# create a ec2 instance
resource "aws_instance" "webserver" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.sg.name]
    key_name = "tf-webserver"
    tags = {
        Name: "flask-app"
    }
    user_data = file("../scripts/env.sh")
      
}
# variable to use in security group for ingress
variable "ingress" {
  type        = list(number)
  default     = [80,443,22,3000]
  description = "security group ports"
}
# variable to use in security group for egress
variable "egress" {
  type        = list(number)
  default     = [80,443]
  description = "security group ports"
}
# Create security group resource
resource "aws_security_group" "sg" {
    name = "Allow web traffic"
    # create multiple ingress blocks with help of iterators
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
    # create multiple egress blocks with help of iterators
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
#output public ip
output ec2-id {
  value       = aws_instance.webserver.public_ip
  description = "ec2 instance public ip"
}
