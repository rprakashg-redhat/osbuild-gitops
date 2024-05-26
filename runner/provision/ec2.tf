module "rhelbuilder" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.8.0"

  name                          = var.instanceName
  instance_count                = 1
  
  instance_type                 = var.instanceType
  ami                           = var.ami
  subnet_id                     = tolist(module.vpc.public_subnets)[0]
  key_name                      = var.sshKey
  vpc_security_group_ids        = [module.public_subnet_sg.security_group_id]
  associate_public_ip_address   = true
  ipv6_addresses = null
  private_ips = ["10.0.3.142"]

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 100
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = 50
      encrypted   = false
    }
  ]

  user_data = <<-EOF
    #!/bin/bash

    sudo dnf -y install ansible-core
    
    ansible-galaxy collection install -f git+https://github.com/redhat-cop/infra.osbuild --upgrade
    ansible-galaxy collection install -f containers.podman --upgrade

  EOF
  
  tags = local.tags
}
