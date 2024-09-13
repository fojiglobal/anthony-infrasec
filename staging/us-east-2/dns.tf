resource "aws_route53_record" "www_test" {
  zone_id = data.aws_route53_zone.segantlabs.zone_id
  name    = "www.${data.aws_route53_zone.segantlabs.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.0.0.1"]
}