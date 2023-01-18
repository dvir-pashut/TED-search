resource "null_resource" "example" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.ec2_dvir.public_ip
      private_key = local_file.tf-key.content
    }

    inline = [
      "cd ted-search && bash init.sh",
    ]
  }
}