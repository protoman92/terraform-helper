locals {
  name_postfix = "${var.service}-${var.microservice}-${var.stage}"

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 443
      target_type      = "instance"
    }
  ]
}

module "sg_ec2" {
  source = "terraform-aws-modules/security-group/aws"
  create = var.create
  name   = "sg_ec2_${replace(local.name_postfix, "-", "_")}"
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

module "sg_alb" {
  source = "terraform-aws-modules/security-group/aws"
  create = var.create
  name   = "sg_alb_${replace(local.name_postfix, "-", "_")}"
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

module "ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = local.name_postfix
  instance_count         = var.create ? 1 : 0
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = local.name_postfix
  monitoring             = true
  vpc_security_group_ids = [module.sg_ec2.this_security_group_id]
  subnet_id              = concat(var.subnet_ids, list(""))[0]

  tags = {
    microservice = var.microservice
    service      = var.service
    stage        = var.stage
  }
}

module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 5.0"
  create_lb          = var.create
  name               = local.name_postfix
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = list(module.sg_alb.this_security_group_id)
  target_groups      = local.target_groups
  vpc_id             = var.vpc_id

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.acm_certificate_arn
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    microservice = var.microservice
    service      = var.service
    stage        = var.stage
  }
}

resource "aws_alb_target_group_attachment" "alb_attachment" {
  count            = var.create ? length(local.target_groups) : 0
  port             = 443
  target_group_arn = element(module.alb.target_group_arns, count.index)
  target_id        = concat(module.ec2.id, list(""))[0]
}

module "r53_record_alb" {
  source          = "cloudposse/route53-alias/aws"
  version         = "0.8.0"
  enabled         = var.create
  aliases         = list("${local.name_postfix}.${var.domain}")
  parent_zone_id  = var.zone_id
  target_dns_name = concat(module.alb.*.this_lb_dns_name, list(""))[0]
  target_zone_id  = module.alb.this_lb_zone_id
}
