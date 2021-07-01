module "ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "${var.project_tags.project}-bastion"
  instance_count = 1

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = ["${module.bastion_sg.security_group_id}"]
  subnet_id              = module.vpc.public_subnets[0]
  tags                   = var.project_tags
}
