variable "profile" {
  type    = string
  default = "default"
}


variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "env" {
  description = "Deployment environment"
  default     = "dev"
}

variable "image_repo_name" {
  description = "Deployment environment"
  default     = "mediumblogpost"
}



variable "image_tag" {
  description = "Deployment ECR Image Tag"
  default     = "latest"
}
variable "github_branch" {
  description = "Github Branch"
  default     = "master"
}

variable "github_repo_name" {
  description = "Github Repo Name"
  default     = "aws-apprunner-e2e"
}


variable "github_repo_owner" {
  description = "Github Repo Owner"
  default     = "aritnag"
}


variable "secrets_manager_name" {
  description = "Secrets Manager Name"
  default     = "apprunnerdemo/mediumblogpost"
}

variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-12345678"
}
