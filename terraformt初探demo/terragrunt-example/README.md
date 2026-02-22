# Terragrunt Example

展示如何用 Terragrunt 管理多環境的 Terraform 專案。

## 目錄結構

```
terragrunt-example/
├── modules/
│   └── ec2/                    # Terraform 模組（寫一次）
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── terragrunt.hcl          # 共用設定（backend、provider）
    ├── dev/
    │   └── terragrunt.hcl      # Dev 參數（t2.micro）
    └── prod/
        └── terragrunt.hcl      # Prod 參數（t3.medium）
```

## Terraform vs Terragrunt 比較

| | 純 Terraform | Terraform + Terragrunt |
|---|---|---|
| Backend 設定 | 每個專案重複寫 | Root 寫一次，自動繼承 |
| Provider 設定 | 每個專案重複寫 | Root 寫一次，自動產生 |
| 多環境管理 | 複製整個資料夾 | 只寫不同的參數 |
| State 路徑 | 手動指定 key | `path_relative_to_include()` 自動推算 |
| 一次部署全部 | 需要寫腳本 | `terragrunt run-all apply` |

## 使用方式

```bash
# 安裝 Terragrunt
brew install terragrunt

# 部署單一環境
cd environments/dev
terragrunt init
terragrunt plan
terragrunt apply

# 部署所有環境
cd environments
terragrunt run-all apply

# 銷毀
terragrunt run-all destroy
```

## 核心概念

- `include` — 繼承上層的 terragrunt.hcl 設定
- `find_in_parent_folders()` — 自動往上找 root terragrunt.hcl
- `path_relative_to_include()` — 自動用相對路徑當 state key（dev/ → dev/terraform.tfstate）
- `inputs` — 傳入 Terraform variables，取代 terraform.tfvars
- `generate` — 自動產生 .tf 檔案（backend.tf、provider.tf）
