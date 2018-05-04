resource "aws_codebuild_project" "project" {
  count        = "${var.count}"
  name         = "${var.name}"
  service_role = "${aws_iam_role.deployment_role.arn}"
  artifacts    = "${list(var.project_artifacts)}"
  environment  = "${list(var.project_environment)}"
  source       = "${list(var.project_source)}"
  tags         = "${var.tags}"
}
