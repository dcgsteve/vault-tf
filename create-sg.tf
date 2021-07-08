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

module "ssh_internal_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "SSH"
  description = "Security group for internal SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  tags                = var.project_tags
}

module "ssh_bastion_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "SSH"
  description = "Security group for bastion SSH access"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks = [ "${module.ec2_bastion.private_ip[0]}/32" ]
  tags                = var.project_tags
}

module "consul_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "consul"
  description = "Security group for Consul"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_with_cidr_blocks = [
    {
      from_port   = 8300
      to_port     = 8300
      protocol    = "tcp"
      description = "Server RPC"
    },
    {
      from_port   = 8301
      to_port     = 8301
      protocol    = "tcp"
      description = "Serf LAN"
    },
  ]

  tags = var.project_tags
}

module "vault_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "vault"
  description = "Security group for Vault"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_with_cidr_blocks = [
    {
      from_port   = 8200
      to_port     = 8200
      protocol    = "tcp"
      description = "Vault API"
    },
  ]

  tags = var.project_tags
}
