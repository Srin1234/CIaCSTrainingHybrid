variable "region" {
  description = "AWS region"
  default = "ap-south-1"
}

variable "ami_id" {
  description = "AMI for ubuntu instance"
  type        = string
  default     = "ami-03f4878755434977f"  #Ubuntu AMI for "ap-south-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default = "Hybrid Test"
}

variable "secgrp_name" {
  description = "EC2 Secutity Group name"
  default = "Hybrid Test SG"
}

variable "location_name" {
  description = "Azure Location"
  default = "West Europe"
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  default = "sriniciactsrg"
}

variable "mysql_server_name" {
  description = "Azure MySQL Server name"
  default = "sriniciactsmysql"
}

variable "mysql_server_login" {
  description = "Azure MySQL Server Login User"
  default = "sriniciactsuser"
}

variable "mysql_server_password" {
  description = "Azure MySQL Server Password"
  default = "Verity@123"
}
