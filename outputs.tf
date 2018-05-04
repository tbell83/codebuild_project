output "deployment_role_arn" {
  value = "${aws_iam_role.deployment_role.arn}"
}

output "project_arn" {
  value = "${aws_codebuild_project.project.id}"
}
