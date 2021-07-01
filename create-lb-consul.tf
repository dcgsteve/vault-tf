module "consul_nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "consul"

  load_balancer_type               = "network"
  internal                         = true
  enable_cross_zone_load_balancing = true

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  target_groups = [
    {
      name_prefix      = "con1-"
      backend_protocol = "TCP"
      backend_port     = 8300
      target_type      = "instance"
      targets = {
          consula = {
              target_id = module.ec2_consul_a.id[0]
              port = 8300
          },
          consulb = {
              target_id = module.ec2_consul_b.id[0]
              port = 8300
          },
          consulc = {
              target_id = module.ec2_consul_c.id[0]
              port = 8300
          }
      }
    },
    {
      name_prefix      = "con2-"
      backend_protocol = "TCP"
      backend_port     = 8301
      target_type      = "instance"
      targets = {
          consula = {
              target_id = module.ec2_consul_a.id[0]
              port = 8301
          },
          consulb = {
              target_id = module.ec2_consul_b.id[0]
              port = 8301
          },
          consulc = {
              target_id = module.ec2_consul_c.id[0]
              port = 8301
          }
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 8300
      protocol           = "TCP"
      target_group_index = 0
    },
    {
      port               = 8301
      protocol           = "TCP"
      target_group_index = 1
    }
  ]

  tags = var.project_tags
}