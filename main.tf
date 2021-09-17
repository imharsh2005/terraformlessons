provider "aws" {
  region = "us-east-1"
  access_key = "AKIA3H57E6LIFJMYI4UR"
  secret_key = "L0pMOigLJOmAMhToLaHUJaUfyRz0eUxxJy7Pio2C"
}

resource "aws_instance" "example"{
  ami = "ami-40d28157"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform-example"
  }
}


