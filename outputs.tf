# Output variable definitions

output "project_details" {
  description = "Details of project"
  value       = var.project_tags
}

output "vault_ips" {
  description = "List of Vault IP's"
  value       = [ module.ec2_vault_a.private_ip, module.ec2_vault_b.private_ip ]
}

output "consul_ips" {
  description = "List of Consul IP's"
  value       = [ module.ec2_consul_a.private_ip, module.ec2_consul_b.private_ip, module.ec2_consul_c.private_ip ]
}

output "bastion_ip" {
  description = "Bastion IP"
  value       = [ module.ec2_bastion.private_ip ]
}
