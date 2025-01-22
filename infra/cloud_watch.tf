#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "logs" {
  name              = "/amazon-ecs/${var.name}/log"
  retention_in_days = 10
  kms_key_id        = "arn:aws:kms:us-east-1:008971661427:key/b1990d78-4db4-46cb-856b-d464bdc15152"
 
}
