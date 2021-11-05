variable "principal" {
  type        = string
  description = "(Required) The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
}

variable "resource_arn" {
  type        = string
  description = "(Required) The Amazon Resource Name (ARN) of the resource share."

}

variable "resource_share_name" {
  type        = string
  description = "The name of the resource share"
}