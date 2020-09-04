module "dynamodb_table" {
  source             = "terraform-aws-modules/dynamodb-table/aws"
  billing_mode       = "PROVISIONED"
  hash_key           = "targetID"
  name               = "${var.service}-${var.stage}-chatbot-cache"
  range_key          = "targetPlatform"
  read_capacity      = var.read_capacity
  ttl_attribute_name = "ttl"
  ttl_enabled        = var.ttl_enabled
  write_capacity     = var.write_capacity

  attributes = [
    {
      name = "targetID"
      type = "S"
    },
    {
      name = "targetPlatform"
      type = "S"
    }
  ]

  tags = {
    service = var.service
    stage   = var.stage
  }
}
