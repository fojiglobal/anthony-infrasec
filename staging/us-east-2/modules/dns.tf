# Define a Route 53 DNS record resource named "staging"
resource "aws_route53_record" "staging" {
  # The ID of the hosted zone where the record will be created
  zone_id = var.zone_id
  
  # The name of the DNS record
  name    = "staging.segantlabs.com"
  
  # The type of DNS record (A record)
  type    = "A"

  # Alias block to point the DNS record to an AWS load balancer
  alias {
    # The DNS name of the load balancer
    name                   = aws_lb.staging_alb.dns_name
    
    # The zone ID of the load balancer
    zone_id                = aws_lb.staging_alb.zone_id
    
    # Whether to evaluate the health of the target
    evaluate_target_health = true
  }
}