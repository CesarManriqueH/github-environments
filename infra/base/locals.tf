locals {
  env_domain_name = var.env_name == "prod" ? "web-app.${var.base_domain}" : "web-app.${var.env_name}.${var.base_domain}"
}
