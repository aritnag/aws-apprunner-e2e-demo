# ---------------------------------------------------------------------------------------------------------------------
# APPRUNNER Service
# ---------------------------------------------------------------------------------------------------------------------
variable "apprunner-instance-role" {}
variable "apprunner-service-role" {}
variable "secrets_manager" {}




resource "aws_apprunner_service" "service" {
  service_name                   = "${var.image_repo_name}"
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto-scaling-config.arn

  source_configuration {
    authentication_configuration {
      access_role_arn = var.apprunner-service-role
    }
    image_repository {
      image_configuration {
        port = 8080
        runtime_environment_variables  = {
          "AWS_REGION" : "${var.aws_region}",
          "DATABASE_URL" : jsondecode(var.secrets_manager.secret_string)["host"],
          "DB_INDENTIFIER" : jsondecode(var.secrets_manager.secret_string)["engine"],
          "spring.datasource.password" : jsondecode(var.secrets_manager.secret_string)["password"],
          "spring.datasource.username" : jsondecode(var.secrets_manager.secret_string)["username"]
        }
      }
      image_identifier      = "${aws_ecr_repository.image_repo.repository_url}:latest"
      image_repository_type = "ECR"
      
    }
    auto_deployments_enabled = true
  }

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.connector.arn
    }
  }

  instance_configuration {
    instance_role_arn = var.apprunner-instance-role
  }
  depends_on = [var.apprunner-service-role, var.apprunner-instance-role, null_resource.apprunner_springboot]
}

 resource "aws_apprunner_vpc_connector" "connector" {
  vpc_connector_name = "apprunnerspringboot-${var.image_repo_name}"
  subnets            = data.aws_subnet_ids.apprunner_vpc_subnets.ids
  security_groups    = data.aws_security_groups.connector_vpc_groups.ids
} 

output "apprunner_service_url" {
  value = "https://${aws_apprunner_service.service.service_url}"
}