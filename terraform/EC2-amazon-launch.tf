provider "aws" {
}

resource "aws_instance" "AWS" {
    ami = "ami-0947d2ba12ee1ff75"
    iam_instance_profile = ""
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ubuntu_ssh.id]
    associate_public_ip_address=true
    key_name = ""
    tags = {
       Name = "test"
    }  
}

resource "aws_security_group" "ubuntu_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

}
