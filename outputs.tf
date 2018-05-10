output "deployment_role_arn" {
  value = "${join(",", aws_iam_role.deployment_role.*.arn)}"
}

output "deployment_role_id" {
  value = "${join(",", aws_iam_role.deployment_role.*.id)}"
}

output "project_arn" {
  value = "${join(",", aws_codebuild_project.project.*.id)}"
}

output "project_name" {
  value = "${join(",", aws_codebuild_project.project.*.name)}"
}
