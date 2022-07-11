
output "domain_link_name" {
  value =var.domain_link
}

output "environment" {
  value =var.env
}

output "my_server_ip" {
  value = aws_eip.my_static_ip.public_ip
}

output "my_instance_id" {
  value = aws_instance.my_server.id
}

output "my_sg_id" {
  value = aws_security_group.my_server.id
}

output "my_instance_type" {
  value = lookup(var.ec2_size, var.env)
}

output "my_region" {
  value = var.region
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}

output "domain_link_public_zone-id" {
  value = aws_route53_zone.domain_link_public_zone.zone_id
}

output "domain_link_name_servers" {
  value = aws_route53_zone.domain_link_public_zone.name_servers
}

output "project_name" {
  value = local.project_owner
}
