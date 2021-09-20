provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example"{
  ami = "ami-40d28157"
  instance_type = "t2.micro"
  key_name= "aws_key"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello this is terraform sample" > index.html
		python3 -m http.server "${var.server_port}"
                EOF
  tags = {
    Name = "Terraform-example"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKFLdrP9IWuTxwyokXX8UdOB7lftjzbczBXhYWYc4TFnQwKY41NybSIS+BVatRGiEmdJbL1LEpjNJ6IYzZsUT5Snfx3t8yPKF4wrfE3wChPO2ORV9U036N2XR9TbBva4JJRXiirw0kV2g235UbaVrzIKZ5BOa4PVelJUBcu+hCdxiudPL8iVtgkSI/XV6XMxBcKgVQZoHvrJiG7g75AqdzEnHzhXYe8ZU2V1dqnvq/QsSRAQ73TmfduVLBFgQ3lwOgjNQNYJmEB3EPEXtNOgPiCoMXeOg4fXcf1nplboe4yIDFAvmODr8k42bf8mt1VXRtwV2cbP6Q5TVPto3CSUBN Harshvardhan.Sharma@MA19LP519298"
}

resource "aws_security_group" "instance"{
	name = "terraform-example-sg"
	  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
     {
     cidr_blocks      = [ "146.115.148.217/32", ]
     description      = "8000 webserver"
     from_port        = "${var.server_port}"
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = "${var.server_port}"
  }
  ]
}


