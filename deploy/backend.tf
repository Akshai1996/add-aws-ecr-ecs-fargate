terraform {
  backend "s3" {
    bucket  = "nodeapp-terraform-remote-bucket"
    encrypt = true
    key     = "tf/add-aws-ecr-ecs-fargate/deploy-ecs.tfstate"
    region  = "us-east-1"
  }
}