# create-sg.tf

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

module "ssh_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "SSH"
  description = "Security group for SSH"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
}