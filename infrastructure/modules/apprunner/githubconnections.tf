resource "aws_apprunner_connection" "apprunner-github-con" {
  connection_name = "apprunner-${var.image_repo_name}"
  provider_type   = "GITHUB"
}