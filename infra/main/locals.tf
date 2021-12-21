locals {
  env_name_prefix = "${var.name_prefix}-${var.env_name}"
  env_domain_name = "${var.env_name}.${var.base_domain}"
}
