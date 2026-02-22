# ============================================================
# Dev Environment — 只定義跟其他環境不同的部分
# ============================================================

# 繼承上層（root）的共用設定（backend、provider）
include "root" {
  path = find_in_parent_folders()
}

# 指定要用哪個 Terraform 模組
terraform {
  source = "../../modules/ec2"
}

# 傳入這個環境專屬的參數
inputs = {
  project_name  = "my-ec2-project"
  environment   = "dev"
  instance_type = "t2.micro" # Dev 用小台的省錢
}
