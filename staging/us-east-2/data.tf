data "aws_route53_zone" "segantlabs" {
  name = "segantlabs.com."
}

############ Web Based AMI ##############

data "aws_ami" "example" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["test-web-*"]
  }
}
# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "alb_cert" {
  domain      = "www.stage.segantlabs.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
output "ami_id" {
  value = data.aws_ami.example.id
}

output "igw_id" {
  value = aws_internet_gateway.staging.id
}