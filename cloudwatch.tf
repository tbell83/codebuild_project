resource "aws_cloudwatch_log_group" "deploy_logs" {
  count             = "${var.count}"
  name              = "/aws/codebuild/${var.name}"
  tags              = "${var.tags}"
  retention_in_days = "${var.retention_in_days}"
}
