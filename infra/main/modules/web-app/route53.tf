resource "aws_route53_record" "root_domain" {
  zone_id = var.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.web_app.domain_name
    zone_id                = aws_cloudfront_distribution.web_app.hosted_zone_id
    evaluate_target_health = false
  }
}
