# ============================================================
# Step 2: 在其他專案中使用 S3 Backend
# ============================================================
# 這個檔案展示如何在你的 EC2 專案中啟用 remote backend。
# 把下面的 terraform block 替換掉 main.tf 裡原本的設定即可。
# ============================================================

terraform {
  required_version = ">= 1.0.0"

  # =========================================================
  # S3 Remote Backend 設定
  # =========================================================
  backend "s3" {
    bucket         = "my-terraform-state-demo-20260222" # Step 1 建的 bucket
    key            = "ec2-project/terraform.tfstate"     # state 在 bucket 中的路徑
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock"              # Step 1 建的 DynamoDB table
    encrypt        = true                                # 加密 state file
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ============================================================
# 使用流程：
# ============================================================
#
# 1. 先跑 Step 1 建好 S3 + DynamoDB：
#    cd s3-backend-example
#    terraform init
#    terraform apply
#
# 2. 把上面的 backend "s3" {} 設定加到你專案的 main.tf
#
# 3. 重新初始化，Terraform 會問你要不要把 local state 搬到 S3：
#    terraform init
#    → "Do you want to copy existing state to the new backend?" → yes
#
# 4. 之後每次 apply，state 都會自動存到 S3
#    terraform apply
#    → 你會看到 "Acquiring state lock..."（DynamoDB 在鎖定）
#
# ============================================================
# 注意事項：
# ============================================================
#
# - bucket name 必須全球唯一，請改成你自己的名字
# - key 用路徑區分不同專案（例如 "ec2-project/", "vpc-project/"）
# - 如果要刪除 backend 資源，要先把所有專案改回 local backend
# - backend block 裡不能用變數（var.xxx），只能寫死值
#   → 這也是 Terragrunt 想解決的問題之一！
# ============================================================
