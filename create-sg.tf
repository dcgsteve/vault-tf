# create-sg.tf

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "bastion"
  description = "Security group for Bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  tags                = var.project_tags
}

module "consul_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "consul"
  description = "Dummy Security group for Consul"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  tags                = var.project_tags
}

module "vault_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "vault"
  description = "Dummy Security group for Vault"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  tags                = var.project_tags
}