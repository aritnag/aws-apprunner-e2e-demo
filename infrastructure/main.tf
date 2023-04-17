

module "apprunner" {
  source = "./modules/apprunner"
  providers = {
    aws = aws
  }
  image_repo_name      = var.image_repo_name
  aws_region           = var.region
  secrets_manager_name = module.database.secrets_manager_credentials.name
  vpc_id               = var.vpc_id
  apprunner-service-role = module.iam_definations.apprunner-service-role
  apprunner-instance-role = module.iam_definations.apprunner-instance-role
  secrets_manager = module.database.secrets_manager_version
}

module "iam_definations" {
  source = "./modules/iam"
  providers = {
    aws = aws
  }
  aws_region           = var.region
  secrets_manager_name = module.database.secrets_manager_credentials.name
  image_repo_name = var.image_repo_name
}

module "database" {
  source = "./modules/database"
  providers = {
    aws = aws
  }
    vpc_id               = var.vpc_id
    secrets_manager_name = var.secrets_manager_name
    image_repo_name = var.image_repo_name
}

module "devops" {
  source = "./modules/devops"
  providers = {
    aws = aws
  }
  github_branch = var.github_branch
  github_repo_name = var.github_repo_name
  github_repo_owner = var.github_repo_owner
  aws_region = var.region
  image_repo_name = var.image_repo_name
  image_tag = var.image_tag

}
