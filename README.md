
# CodeBuild Project

Most of the necessary bits to create a new project in CodeBuild

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| count |  | string | `1` | no |
| create_bucket |  | string | `False` | no |
| name | Prefix for module resources | string | - | yes |
| project_artifacts | https://www.terraform.io/docs/providers/aws/r/codebuild_project.html#artifacts | map | - | yes |
| project_environment | https://www.terraform.io/docs/providers/aws/r/codebuild_project.html#environment | map | - | yes |
| project_source | https://www.terraform.io/docs/providers/aws/r/codebuild_project.html#source | map | - | yes |
| retention_in_days | Length of cloudwatch log retention in days | string | `30` | no |
| tags | Tags | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment_role_arn |  |
| project_arn |  |
