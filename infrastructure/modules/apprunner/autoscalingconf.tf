resource "aws_apprunner_auto_scaling_configuration_version" "auto-scaling-config" {
  auto_scaling_configuration_name = "apprunnerspringboot-config"
  max_concurrency                 = 50
  max_size                        = 10
  min_size                        = 2

  tags = {
    Name = "apprunner-auto-scaling-apprunnerspringboot-config"
  }
}