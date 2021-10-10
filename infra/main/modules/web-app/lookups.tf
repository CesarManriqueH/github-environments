data "aws_acm_certificate" "cert" {
  domain = local.domain_name
}
