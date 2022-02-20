locals {
  env_domain_name = var.env_name == "prod" ? var.base_domain : "${var.env_name}.${var.base_domain}"
}
