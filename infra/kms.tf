#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
resource "aws_kms_key" "custom_kms_key" {
  description             = "KMS key for app-6"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias
resource "aws_kms_alias" "key" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.custom_kms_key.id
}
