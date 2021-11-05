

locals {
  networking_account  = [for key, value in var.organization_structure : key if key == "networking"][0]
  perimeter_account   = [for key, value in var.organization_structure : key if key == "perimeter"][0]
  air_traffic_control = { for id in keys(var.organization_structure) : id => module.organization_accounts_structure[id].ids }
  all_ids             = { for id in keys(var.organization_structure) : id => module.organization_accounts_structure[id].ids }
}