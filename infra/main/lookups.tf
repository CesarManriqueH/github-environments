data "aws_route53_zone" "zone" {
  name         = var.base_domain
  private_zone = false
}
