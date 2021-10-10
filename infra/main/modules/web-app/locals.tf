locals {
  name        = "${var.name_prefix}-web-app"
  domain_name = "web-app.${var.base_domain}"
  origin_id   = "Web app in ${var.env_name}"
  bucket_name = local.name
  origin_path = "/assets"
}
