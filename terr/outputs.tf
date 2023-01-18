output "ec2s_ips" {
  description = "the ips of the ec2"
  value       = aws_instance.ec2_dvir.public_ip
}