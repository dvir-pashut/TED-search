variable "region" {
  description = "the region to use"
  default     = "eu-central-1"
}

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

variable "vpc-name" {
  type        = string
  description = "vpc name"
  default     = "ted-search-vpc"
}

variable "subnet-name" {
  type        = string
  description = "subnet name"
  default     = "ted-search-subnet"
}

variable "sub-ip" {
  description = "ip for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc-ip" {
  description = "vpc-ip"
  default     = "10.0.0.0/16"
}

variable "AZ" {
  description = "the az to work on"
}

variable "ec2-name" {
  type        = string
  description = "ec2 name"
  default     = "ted-search-machine"
}

data "local_file" "user-data" {
  filename = "user-data.txt"
}

data "local_file" "what-to-send" {
  filename = "pwd.txt"
}