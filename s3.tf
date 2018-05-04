resource "aws_s3_bucket" "deployment_bucket" {
  count  = "${var.project_artifacts["type"] == "S3" && var.create_bucket == "true" ? var.count : 0}"
  bucket = "${var.project_artifacts["location"]}"
}

data "aws_s3_bucket" "deployment_bucket" {
  count  = "${var.project_artifacts["type"] == "S3" ? var.count : 0}"
  bucket = "${var.project_artifacts["location"]}"
}

resource "aws_s3_bucket_policy" "deployment_bucket" {
  count  = "${var.project_artifacts["type"] == "S3" ? var.count : 0}"
  policy = "${data.aws_iam_policy_document.deployment_bucket.json}"
  bucket = "${data.aws_s3_bucket.deployment_bucket.id}"
}

data "aws_iam_policy_document" "deployment_bucket" {
  statement {
    sid     = "CodeBuild"
    actions = ["s3:*"]

    resources = [
      "${join(",", data.aws_s3_bucket.deployment_bucket.*.arn)}",
      "${join(",", data.aws_s3_bucket.deployment_bucket.*.arn)}/*",
    ]

    principals {
      identifiers = ["${aws_iam_role.deployment_role.arn}"]
      type        = "AWS"
    }
  }
}
