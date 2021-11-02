

resource "aws_iam_role" "auditor" {
  name               = "Auditor"
  assume_role_policy = local.policy_assume_role
  tags = {
    "terraform-managed" : true
  }
}

resource "aws_iam_role" "developer" {
  name               = "Developer"
  assume_role_policy = local.policy_assume_role
  tags = {
    "terraform-managed" : true
  }
}

// Give roles the desired permissions

resource "aws_iam_role_policy_attachment" "auditor" {

  role       = aws_iam_role.auditor.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "developer" {
  for_each = toset([
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
  ])
  role       = aws_iam_role.developer.name
  policy_arn = each.key
}