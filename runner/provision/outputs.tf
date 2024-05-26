output "publicIp" {
  description = "Public IP address of the EC2 instance"
  value = module.rhelbuilder.public_ip
}

output "publicDns" {
  description = "Public DNS of the EC2 instance"
  value = module.rhelbuilder.public_dns
}