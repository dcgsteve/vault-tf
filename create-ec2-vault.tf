module "ec2_vault_a" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "${var.project_tags.project}-vault-a"
  instance_count = 1

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = ["${module.vault_sg.security_group_id}"]
  subnet_id              = module.vpc.private_subnets[0]
  tags                   = var.project_tags
}

module "ec2_vault_b" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "${var.project_tags.project}-vault-b"
  instance_count = 1

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = ["${module.vault_sg.security_group_id}"]
  subnet_id              = module.vpc.private_subnets[1]
  tags                   = var.project_tags
}
