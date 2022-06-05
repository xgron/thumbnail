variable "region" {
    type = string
    description = "The region in which to create/manage resources"
    default = "eu-north-1"
}

variable "account_id"{
  type        = string
  description = "The account ID in which to create/manage resources"
}