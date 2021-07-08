module "ec2_consul_a" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "${var.project_tags.project}-consul-a"
  instance_count = 1

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = ["${module.consul_sg.security_group_id}", "${module.ssh_internal_sg.security_group_id}", "${module.ssh_bastion_sg.security_group_id}"]

  subnet_id              = module.vpc.private_subnets[0]
  tags                   = var.project_tags
}

module "ec2_consul_b" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "${var.project_tags.project}-consul-b"
  instance_count = 1

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = ["${module.consul_sg.security_group_id}", "${module.ssh_internal_sg.security_group_id}", "${module.ssh_bastion_sg.security_group_id}"]
  subnet_id              = module.vpc.private_subnets[1]
  tags                   = var.project_tags
}

module "ec2_consul_c" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "${var.project_tags.project}-consul-c"
  instance_count = 1

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = ["${module.consul_sg.security_group_id}", "${module.ssh_internal_sg.security_group_id}", "${module.ssh_bastion_sg.security_group_id}"]
 subnet_id              = module.vpc.private_subnets[2]
  tags                   = var.project_tags
}