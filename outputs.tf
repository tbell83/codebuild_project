output "deployment_role_arn" {
  value = "${join(",", aws_iam_role.deployment_role.*.arn)}"
}

output "project_arn" {
  value = "${join(",", aws_codebuild_project.project.*.id)}"
}
