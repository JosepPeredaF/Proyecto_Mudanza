data "aws_caller_identity" "current" {}

resource "aws_kms_key" "logs" {
  description             = "Clave KMS para cifrar los log groups de CloudWatch"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AdministracionCuenta"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        Sid       = "PermitirCloudWatchLogs"
        Effect    = "Allow"
        Principal = { Service = "logs.${var.aws_region}.amazonaws.com" }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_cloudwatch_log_group" "api_web" {
  name              = "/ecs/${var.project}-${var.environment}-api-web"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "worker_gps" {
  name              = "/ecs/${var.project}-${var.environment}-worker-gps"
  retention_in_days = 7
}
