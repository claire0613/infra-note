# ============================================================
# Input Variables
# ============================================================

# -----------------------------
# General Settings
# -----------------------------
variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "terraform-ec2-demo"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-1"
}

# -----------------------------
# VPC Settings
# -----------------------------
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "ap-northeast-1a"
}

# -----------------------------
# EC2 Settings
# -----------------------------
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to create"
  type        = string
  default     = "my-ec2-key"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (leave empty to use latest Amazon Linux 2023)"
  type        = string
  default     = ""
}

# -----------------------------
# Security Settings
# -----------------------------
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the instance (e.g., your IP: x.x.x.x/32)"
  type        = string
  default     = "0.0.0.0/0" # WARNING: Open to world - change this in production!
}
