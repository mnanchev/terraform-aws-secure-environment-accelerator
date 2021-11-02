# Copyright 2021 Martin Nanchev
resource "aws_iam_account_alias" "alias" {
  account_alias = var.account_name
}