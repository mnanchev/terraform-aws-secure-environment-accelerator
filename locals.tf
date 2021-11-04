

locals {
  air_traffic_control = { for id in keys(var.organization_structure) : id => module.organization_accounts_structure[id].ids }
  all_ids             = { for id in keys(var.organization_structure) : id => module.organization_accounts_structure[id].ids }
}