# Terraform 基本テンプレート

これはオレオレ Terraform テンプレートです。

- VPC * 1
- Public Subnet / Private Subnet * 3 ( per AZ)
- ELB * 1
- EC2 * 3
- RDS (Aurora MySQL) * 1


# DEMO
下記の構成が出来上がります。

( 構成図挿入予定 )

# Features

terraform.tfvars の変数を修正して `terraform apply` するだけで、WEB ３ 層構造が作成されます。
難しい作りにしていないので、変更しやすい作りになっています。

# Requirement
Terraform Registry から module をダウンロードしますので、Terraform Registry に接続できる環境で実行してください。

* Terraform v0.12.24 later
* direnv 2.21.3 later
* aws-cli 1.16 later

# Installation

## Terraform  のインストール
### 1. tfenv のインストール
```bash
brew install tfenv
```
### 2. tfenv でインストールできるバージョンの確認
```bash
tfenv list-remote
```
### 3. terraform のインストール
```bash
tfenv install 0.12.24
```

# Usage
## リポジトリをクローンする
```bash
git clone git@github.com:higaTousan/base_terraform.git
cd base_terraform
```
## 環境変数 AWS_PROFILE を設定する
```bash
vim .envrc
```
## YOUR_PROFILE_NAME を接続先 AWS アカウントのプロファイルに書き換えてください。
``` text:.envrc
export AWS_PROFILE="YOUR_PROFILE_NAME"
```
```
direnv allow
```
## 構築先 AWS アカウントへの接続を確認する
```bash
aws sts get-caller-identity
```
## terrafrom init で module をダウンロードする
```bash
terraform init
```
## terraform.tfvars を構築する環境に合わせて修正する
```bash
cp terraform.tfvars.bk terraform.tfvars
vim terraform.tfvars
```
## terraform を実行する
```bash
terraform plan
```
```bash
terraform apply
```
## 公式ドキュメント
https://www.terraform.io/docs/index.html

# Note

注意点とくになし

