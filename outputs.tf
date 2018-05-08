output "deployment_role_arn" {
  value = "${join(",", aws_iam_role.deployment_role.*.arn)}"
}

output "project_arn" {
  value = "${join(",", aws_codebuild_project.project.*.id)}"
}

output "project_name" {
  value = "${join(",", aws_codebuild_project.project.*.name)}"
}
