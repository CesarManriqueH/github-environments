locals {
  domain_names = concat([var.domain_name], var.subject_alternative_names)
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.subject_alternative_names

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count = length(local.domain_names)
  name  = element(tolist(aws_acm_certificate.cert.domain_validation_options), count.index)["resource_record_name"]
  type  = element(tolist(aws_acm_certificate.cert.domain_validation_options), count.index)["resource_record_type"]
  records = [
    element(tolist(aws_acm_certificate.cert.domain_validation_options), count.index)["resource_record_value"]
  ]
  zone_id = var.zone_id
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}
