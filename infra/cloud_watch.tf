#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "logs" {
  name              = "/amazon-ecs/${var.name}/log"
  retention_in_days = 14
  kms_key_id        = var.kms_key_id
 
}
