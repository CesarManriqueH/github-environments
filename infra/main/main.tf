module "web_app" {
  source      = "./modules/web-app"
  name_prefix = var.name_prefix
  base_domain = local.env_domain_name
  env_name    = var.env_name
  zone_id     = data.aws_route53_zone.zone.zone_id
}
