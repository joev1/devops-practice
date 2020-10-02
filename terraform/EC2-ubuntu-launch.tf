provider "aws" {
    region = ""
}

resource "aws_instance" "ubuntu" {
    ami = "ami-0817d428a6fb68645"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ubuntu_ssh.id]
//    vpc_security_group_ids = [""]
//id of the public subnet so that the instance is accessible via internet to do SSH
//    subnet_id = "<<subnet_id>>"

    //id of the security group which has ports open to all the IPs
//    vpc_security_group_ids=["<<security_group_id>>"]

    //assigning public IP to the instance is required.
    associate_public_ip_address=true
    key_name = ""
    tags = {
       Name = "cluster"
    }
    /*
    provisioner "remote-exec" {
        inline = [
            //Executing command to creating a file on the instance
            "echo 'Some data' > SomeData.txt",
        ]
    
        //Connection to be used by provisioner to perform remote executions
        connection {
            //Use public IP of the instance to connect to it.
            host          = "${aws_instance.t2.micro.public_ip}"
            type          = "ssh"
            user          = "ubuntu"
            private_key   = "${file("<<pem_file>>")}"
            timeout       = "1m"
            agent         = false
        }  
    }
   */    
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
