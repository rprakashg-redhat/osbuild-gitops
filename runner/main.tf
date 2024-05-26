provider "aws" {
    region = var.region
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {

    azs                     = slice(data.aws_availability_zones.available.names, 0, 3)
    vpc_cidr                = "10.0.0.0/16" 
            
    tags = {
        owner: "Ram Gopinathan"
        email: "rprakashg@gmail.com"
        website: "https://rprakashg.github.io"
        stack: var.stack
    }
}