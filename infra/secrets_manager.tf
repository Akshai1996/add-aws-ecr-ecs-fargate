
resource "aws_secretsmanager_secret" "ecs_secret" {
  name                    = "ecs_secret"
  recovery_window_in_days = 0
  kms_key_id              = aws_kms_key.custom_kms_key.id
}

resource "aws_secretsmanager_secret_version" "ecs_secret_version" {
  secret_id     = aws_secretsmanager_secret.ecs_secret.id
  secret_string = var.ecs_secret
}