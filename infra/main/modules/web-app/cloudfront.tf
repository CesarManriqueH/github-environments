resource "aws_cloudfront_distribution" "web_app" {
  enabled             = true
  price_class         = "PriceClass_All"
  default_root_object = "index.html"
  comment             = "web_app-${var.name_prefix}"

  aliases = [local.domain_name]

  origin {
    domain_name = aws_s3_bucket.web_app_assets.bucket_regional_domain_name
    origin_id   = local.origin_id
    origin_path = local.origin_path
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.web_app.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 3600
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  custom_error_response {
    error_code            = "403"
    response_code         = "200"
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "web_app" {
  comment = "Origin Access ID for ${local.origin_id}"
}
