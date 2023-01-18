resource "aws_instance" "ec2_dvir" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.pub-sub.id
  vpc_security_group_ids      = [aws_security_group.sshhttp.id]
  associate_public_ip_address = true
  user_data                   = data.local_file.user-data.content
  key_name                    = local_file.tf-key.filename

  provisioner "file" {
        source      = "/home/ubuntu/ted-search"
        destination = "/home/ubuntu"
       
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.ec2_dvir.public_ip
      private_key = local_file.tf-key.content
    }
  }

   /* }
   provisioner "file" {
        source      = "/home/ubuntu/ted-search/terr/image.tar"
        destination = "/home/ubuntu/image.tar"
       
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.ec2_dvir.public_ip
      private_key = local_file.tf-key.content
    }
   }
    provisioner "file" {
        source      = "/home/ubuntu/ted-search/terr/init.sh"
        destination = "/home/ubuntu/init.sh"
       
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.ec2_dvir.public_ip
      private_key = local_file.tf-key.content
    }

   } */



  tags = merge(var.tags, {
    Name = format("%s-%s",var.ec2-name,"${terraform.workspace}")
  })
}


resource "aws_security_group" "sshhttp" {
  name        = "allow_tls-${terraform.workspace}"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.tr_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
    Name = "allow ssh and http-${terraform.workspace}"
  })
}


resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "tf-key-pair"
}

