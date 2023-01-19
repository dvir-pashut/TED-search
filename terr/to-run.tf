resource "null_resource" "example" {
  triggers = {
    instance_id = aws_instance.ec2_dvir.id
  }
  
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.ec2_dvir.public_ip
      private_key = local_file.tf-key.content
    }

    inline = [
      "cd to-send && bash init.sh",
    ]
  }
}