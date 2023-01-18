variable "tags" {
  description = "defoult tags"
  type        = map(string)
  default = {
    owner           = "dvir-pashut"
    bootcamp        = "17"
    expiration_date = "01-04-23"
  }

}

variable "ami" {
  description = "the ec2 image"
}

variable "instance_type" {
  description = "the ec2 type"
  type        = string
  default     = "t3a.micro"
}
