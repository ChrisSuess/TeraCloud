provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0442f9e87aa896922"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello world, $(whoami) at $(date)" > index.html
              #echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
 
  tags = {
    name = "TF-Example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance" 

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the web server"
}
