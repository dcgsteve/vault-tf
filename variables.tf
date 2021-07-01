##################################
# General
##################################

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "project_tags" {
  description = "Tags to apply to resources allocated to project"
  type        = map(string)
  default = {
    project         = "ecp-vault"
    environment     = "dev"
    primary_contact = "Steve Cliff"
    primary_email   = "steve.cliff@atos.net"
  }
}


##################################
# Instance
##################################

variable "instance_ami" {
  description = "ID of the AMI used"
  type        = string
  default     = "ami-03bb77caf81b15cc5" # Ubuntu 20.04 LTS
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t2.micro" # Just for testing with
}

variable "instance_keypair" {
  description = "SSH Key pair to allocate to instances"
  type        = string
  default     = "ecp-vault" # DBG Regen this prior to putting live
}
