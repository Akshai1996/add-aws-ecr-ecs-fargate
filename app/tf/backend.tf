terraform {
  backend "s3" {
    bucket  = "nodeapp-terraform-remote-bucket"
    encrypt = true
    key     = "tf/add-aws-ecr-ecs-fargate/terraform.tfstate"
    region  = "us-east-1"
    dynamodb_table = "terraform-backend-nodejs-app"
  }
}