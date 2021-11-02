variable "aws_region" {
  type = string
}
variable "aws_cli_profile" {
  type = string
}

variable "customer" {
  type = string
}

variable "email" {
  type = string
}

variable "account_name" {
  type = string
}

variable "reader_users" {
  type    = list(string)
  default = []
}
variable "dev_users" {
  type    = list(string)
  default = []
}
variable "owner_users" {
  type    = list(string)
  default = []
}

variable "air_traffic_control_role" {
  type    = string
  default = "AirTrafficControl"
}

variable "ou" {}

variable "parent" {}