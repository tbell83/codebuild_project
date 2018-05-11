variable "count" {
  default = 1
}

variable "name" {
  description = "Prefix for module resources"
}

variable "tags" {
  description = "Tags"
  type        = "map"

  default = {
    "Managed" = "Terraform"
    "Name"    = "codebuild"
  }
}

variable "retention_in_days" {
  description = "Length of cloudwatch log retention in days"
  default     = 30
}

variable "project_environment" {
  description = "https://www.terraform.io/docs/providers/aws/r/codebuild_project.html#environment"
  type        = "map"
}

variable "project_artifacts" {
  description = "https://www.terraform.io/docs/providers/aws/r/codebuild_project.html#artifacts"
  type        = "map"
}

variable "project_source" {
  description = "https://www.terraform.io/docs/providers/aws/r/codebuild_project.html#source"
  type        = "map"
}

variable "create_bucket" {
  default = "False"
}

variable "assume_deployment" {
  default = []
}

variable "deployment_role_name" {
  default     = "none"
  description = "Friendly name of the role codebuild will assume, if not set, the module will create an appropriate role."
}
