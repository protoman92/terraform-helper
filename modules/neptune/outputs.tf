output "cluster_hostnames" {
  value = module.route53-alias.hostnames
}

output "cluster_arn" {
  value = concat(aws_neptune_cluster.cluster.*.arn, list(""))[0]
}

output "cluster_endpoint" {
  value = concat(aws_neptune_cluster.cluster.*.endpoint, list(""))[0]
}

output "cluster_id" {
  value = concat(aws_neptune_cluster.cluster.*.id, list(""))[0]
}

output "security_group_id" {
  value = module.sg.this_security_group_id
}
