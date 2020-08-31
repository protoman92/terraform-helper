locals {
  cluster_identifier = "${var.service}-${var.microservice}-${var.stage}"
}

module "sg" {
  source = "terraform-aws-modules/security-group/aws"
  create = var.create
  name   = "sg_neptune_${local.cluster_identifier}"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

resource "aws_neptune_cluster" "cluster" {
  count                               = var.create ? 1 : 0
  apply_immediately                   = true
  backup_retention_period             = 5
  cluster_identifier                  = local.cluster_identifier
  engine                              = "neptune"
  iam_database_authentication_enabled = var.enable_iam_authentication
  port                                = var.port
  preferred_backup_window             = var.preferred_backup_window
  skip_final_snapshot                 = true
  storage_encrypted                   = true
  vpc_security_group_ids              = list(module.sg.this_security_group_id)
  tags = {
    microservice = var.microservice
    service      = var.service
    stage        = var.stage
  }
}

resource "aws_neptune_cluster_instance" "instance" {
  count              = var.create ? var.instance_count : 0
  apply_immediately  = true
  cluster_identifier = concat(aws_neptune_cluster.cluster.*.id, list(""))[0]
  engine             = "neptune"
  instance_class     = var.instance_class
  tags = {
    microservice = var.microservice
    service      = var.service
    stage        = var.stage
  }
}

module "route53-alias" {
  source          = "cloudposse/route53-alias/aws"
  version         = "0.8.0"
  enabled         = var.create
  aliases         = list("${local.cluster_identifier}.${var.domain}")
  parent_zone_id  = var.zone_id
  target_dns_name = concat(aws_neptune_cluster.cluster.*.endpoint, list(""))[0]
  target_zone_id  = concat(aws_neptune_cluster.cluster.*.hosted_zone_id, list(""))[0]
}
