data "aws_route53_zone" "my_zone_id" {
  name         = "${var.base_domain}."
  private_zone = false
}

module "web_app_cert" {
  source      = "./modules/acm-cert"
  domain_name = local.env_domain_name
  zone_id     = data.aws_route53_zone.my_zone_id.zone_id
}
