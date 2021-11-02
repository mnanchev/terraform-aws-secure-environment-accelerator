output "ids" {
  value = aws_organizations_account.account.id
}

output "air_traffic_control" {
  value = var.air_traffic_control_role
}