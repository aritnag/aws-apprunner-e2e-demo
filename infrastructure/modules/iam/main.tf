
data "aws_caller_identity" "current" {}
variable "aws_region" {}
variable "secrets_manager_name" {}
variable "image_repo_name" {}

# ---------------------------------------------------------------------------------------------------------------------
# APPRUNNER IAM Role
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role" "apprunner-service-role" {
  name               = "apprunner_springboot-AppRunnerECRAccessRole-${var.image_repo_name}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.apprunner-service-assume-policy.json
}

data "aws_iam_policy_document" "apprunner-service-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "apprunner-service-role-attachment" {
  role       = aws_iam_role.apprunner-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}


resource "aws_iam_role" "apprunner-instance-role" {
  name               = "apprunner_springboot-AppRunnerInstanceRole-${var.image_repo_name}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.apprunner-instance-assume-policy.json
}

resource "aws_iam_policy" "Apprunner-policy" {
  name   = "Apprunner-GetSecretsManager-${var.image_repo_name}"
  policy = data.aws_iam_policy_document.apprunner-instance-role-policy.json
}

resource "aws_iam_role_policy_attachment" "apprunner-instance-role-attachment" {
  role       = aws_iam_role.apprunner-instance-role.name
  policy_arn = aws_iam_policy.Apprunner-policy.arn
}

resource "aws_iam_role_policy_attachment" "apprunner-instance-role-xray-attachment" {
  role       = aws_iam_role.apprunner-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

data "aws_iam_policy_document" "apprunner-instance-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["tasks.apprunner.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "apprunner-instance-role-policy" {
  statement {
    actions = ["secretsmanager:GetSecretValue", "kms:Decrypt*"]
    effect  = "Allow"
    resources = ["arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:${var.secrets_manager_name}",
    "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:key/d3f0d777-c263-4a95-9e1b-deda29b3a40e"]
  }
}