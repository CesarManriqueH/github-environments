resource "aws_s3_bucket" "web_app_assets" {
  bucket = local.bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "web_app_access_block" {
  bucket                  = aws_s3_bucket.web_app_assets.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "web_app_bucket_policy_document" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.web_app.iam_arn]
    }
    resources = ["${aws_s3_bucket.web_app_assets.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "web_app_bucket_policy" {
  bucket = aws_s3_bucket.web_app_assets.id
  policy = data.aws_iam_policy_document.web_app_bucket_policy_document.json
}
