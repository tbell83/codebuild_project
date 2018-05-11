resource "aws_iam_role" "deployment_role" {
  count              = "${var.deployment_role_name == "none" ? var.count : 0}"
  name               = "${var.name}-deployment-role"
  assume_role_policy = "${data.aws_iam_policy_document.deployment_role_assumption.json}"
}

data "aws_iam_policy_document" "deployment_role_assumption" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type        = "Service"
    }

    principals {
      identifiers = "${compact(var.assume_deployment)}"
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "ecr" {
  count = "${var.count}"

  statement {
    sid       = "CodeCommitPolicy"
    actions   = ["codecommit:GitPull"]
    resources = ["*"]
  }

  statement {
    sid = "CloudWatchLogsPolicy"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${join(",", aws_cloudwatch_log_group.deploy_logs.*.arn)}",
      "${join(",", aws_cloudwatch_log_group.deploy_logs.*.arn)}:*",
    ]
  }

  statement {
    sid = "DockerPush"

    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
    ]

    resources = ["arn:aws:ecr:*:${data.aws_caller_identity.current.account_id}:repository/*"]
  }

  statement {
    sid       = "GetEcrAuthToken"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  source_json = "${var.project_artifacts["type"] == "S3" ? "${data.aws_iam_policy_document.s3_access.json}" : ""}"
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    sid = "S3Policy"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
    ]

    resources = [
      "${join(",", data.aws_s3_bucket.deployment_bucket.*.arn)}",
      "${join(",", data.aws_s3_bucket.deployment_bucket.*.arn)}/*",
    ]
  }
}

resource "aws_iam_role_policy" "deployment_role" {
  count  = "${var.deployment_role_name == "none" ? var.count : 0}"
  name   = "${var.name}-ecr"
  role   = "${data.aws_iam_role.deployment_role.id}"
  policy = "${data.aws_iam_policy_document.ecr.json}"
}

data "aws_iam_role" "deployment_role" {
  count = "${var.count}"
  name  = "${var.deployment_role_name != "none" ? var.deployment_role_name : join("", aws_iam_role.deployment_role.*.name)}"
}
