module "vault_nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "vault"

  load_balancer_type               = "network"
  internal                         = false
  enable_cross_zone_load_balancing = true

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  target_groups = [
    {
      name_prefix      = "vlt1-"
      backend_protocol = "TCP"
      backend_port     = 8200
      target_type      = "instance"
      targets = {
        vaulta = {
          target_id = module.ec2_vault_a.id[0]
          port      = 8200
        },
        vaultb = {
          target_id = module.ec2_vault_b.id[0]
          port      = 8200
        }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 8200
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  tags = var.project_tags
}