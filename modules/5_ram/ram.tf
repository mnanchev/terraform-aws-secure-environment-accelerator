
resource "aws_ram_resource_share" "share" {
  name = var.resource_share_name
}


resource "aws_ram_resource_association" "share_association" {
  resource_arn       = var.resource_arn
  resource_share_arn = aws_ram_resource_share.share.arn
}


resource "aws_ram_principal_association" "share_association_principal" {
  principal          = var.principal
  resource_share_arn = aws_ram_resource_share.share.arn
}