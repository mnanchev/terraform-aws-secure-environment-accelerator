output "all_ids" {
  value = { for id in keys(var.organization_structure) : id => module.organization_accounts_structure[id].ids }
}

output "air_traffic_control" {
  value = { for id in keys(var.organization_structure) : id => module.organization_accounts_structure[id].ids }
}