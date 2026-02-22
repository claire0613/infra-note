# ============================================================
# Root Terragrunt Config — 所有環境的共用設定
# ============================================================
# 子資料夾的 terragrunt.hcl 會自動繼承這裡的設定
# 用 include {} 引入
# ============================================================

# -----------------------------
# Remote Backend（自動產生）
# -----------------------------
# Terragrunt 最強的功能之一：自動幫你產生 backend 設定
# 不用在每個模組裡重複寫 backend "s3" {}
remote_state {
  backend = "s3"

  config = {
    bucket         = "my-terraform-state-demo-20260222"
    key            = "${path_relative_to_include()}/terraform.tfstate" # 自動用資料夾路徑當 key！
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  # 如果 bucket 不存在，自動建立
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# -----------------------------
# Provider（自動產生）
# -----------------------------
# 同樣不用在每個模組裡重複寫 provider "aws" {}
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region = "ap-northeast-1"
}
EOF
}
