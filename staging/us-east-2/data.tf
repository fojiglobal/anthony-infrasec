# Fetches the Route 53 hosted zone information for the domain "segantlabs.com."
data "aws_route53_zone" "segantlabs" {
  name = "segantlabs.com."
}

# Fetches the most recent AWS ACM certificate for the domain "www.stage.segantlabs.com"
# that is issued by Amazon
data "aws_acm_certificate" "alb_cert" {
  domain      = "www.stage.segantlabs.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}