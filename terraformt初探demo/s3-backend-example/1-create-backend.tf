# ============================================================
# Step 1: 先建立 S3 Bucket 和 DynamoDB Table
# ============================================================
# 注意：這個檔案要「先」單獨 apply，建好儲存空間後，
# 其他專案才能用它當 backend。
# 這是一個雞生蛋的問題：backend 本身要用 local state 管理。
# ============================================================

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

# -----------------------------
# S3 Bucket — 存放 tfstate
# -----------------------------
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-demo-20260222" # 必須全球唯一

  # 防止誤刪（正式環境建議開啟）
  # lifecycle {
  #   prevent_destroy = true
  # }

  tags = {
    Name      = "Terraform State"
    ManagedBy = "Terraform"
  }
}

# 啟用版本控制 — 可回復舊版 state
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 啟用加密 — state 裡可能有密鑰
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 禁止公開存取
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# -----------------------------
# DynamoDB Table — State Locking
# -----------------------------
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST" # 用多少付多少，練習基本免費

  hash_key = "LockID" # Terraform 固定用這個 key

  attribute {
    name = "LockID"
    type = "S" # String
  }

  tags = {
    Name      = "Terraform State Lock"
    ManagedBy = "Terraform"
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.id
  description = "把這個值填入其他專案的 backend 設定"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_lock.id
  description = "把這個值填入其他專案的 backend 設定"
}
