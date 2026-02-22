# ============================================================
# Prod Environment — 只定義跟其他環境不同的部分
# ============================================================

# 繼承上層（root）的共用設定（backend、provider）
include "root" {
  path = find_in_parent_folders()
}

# 用同一個 Terraform 模組
terraform {
  source = "../../modules/ec2"
}

# Prod 環境用不同的參數
inputs = {
  project_name  = "my-ec2-project"
  environment   = "prod"
  instance_type = "t3.medium" # Prod 用大一點的
}
