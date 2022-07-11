
module "aws_ecr_docker_image" {
  source      = "github.com/domorelivelonger/terraform-aws-ecr-docker-image?ref=v4.0"
  image_name  = "django_test"
  source_path = "../"
}
