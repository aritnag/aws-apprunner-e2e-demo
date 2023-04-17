
# ---------------------------------------------------------------------------------------------------------------------
# Secrets Manager Parameters for RDS 
# ---------------------------------------------------------------------------------------------------------------------

variable "secrets_manager_name" {}
data "aws_secretsmanager_secret" "apprunnerdemo" {
  name = var.secrets_manager_name
  depends_on = [
    var.secrets_manager_name
  ]
}



# ---------------------------------------------------------------------------------------------------------------------
# Security Groups for Creating the AppRunner VPC Connector
# ---------------------------------------------------------------------------------------------------------------------

data "aws_security_groups" "connector_vpc_groups" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# VPC details
# ---------------------------------------------------------------------------------------------------------------------


variable "vpc_id" {}
data "aws_vpc" "apprunner_vpc" {
  id = var.vpc_id
}
data "aws_subnet_ids" "apprunner_vpc_subnets" {
  vpc_id = var.vpc_id
}

