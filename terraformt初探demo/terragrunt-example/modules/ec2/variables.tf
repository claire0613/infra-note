variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
