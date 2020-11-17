# Terraform for AWS Secrets Manager

AWS Secrets Manager のデモ環境ができあがります。

# Diagram
![Diagram-SecretsManagerDemo](https://user-images.githubusercontent.com/147642/99356505-9d848500-28ed-11eb-8596-b09ef6f0c548.png)

# Requirement

* Terraform v0.13.5
* direnv 2.21.3


# Usage

## クライアント端末での作業
### 1. terraform のダウンロード

```bash
git clone git@github.com:higaTousan/base_terraform.git
cd base_terraform/2layers
```

### 2. direnv 設定

```bash
direnv edit .
```

```editor
export AWS_PROFILE=<YOURPROFILE>
```

### 3. AWS 接続確認

Account が接続先と同じであることを確認します。

```bash
aws sts get-caller-identity
```

### 4. terraform 実行

```bash
terraform init
terrafrom plan
terraform apply
```
## AWS コンソールでの作業

### 5. Secrets Manager 作成
- Secrets Manager を作成
- ローテーション設定
- ローテーション Lambda に Security Group をアタッチ

## EC2 での作業

### 6. EC2 の設定

- SSM 経由でログイン
- yum アップデート

```bash
sudo yum update
```

- jq インストール

```bash
sudo yum install jq
```

- mysql クライアントインストール

```bash
sudo yum localinstall -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo yum-config-manager --disable mysql57-community
sudo yum-config-manager --enable mysql80-community
sudo yum install mysql-community-client

mysql --version
mysql  Ver 8.0.22 for Linux on x86_64 (MySQL Community Server - GPL)
```

- RDS MySQL に接続確認
```bash
mysql -h {ENDPOINT} -P 3306 -u {Username} –p
Enter password:

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>

```

- Region の設定

```bash
aws configure
AWS Access Key ID [None]:
AWS Secret Access Key [None]:
Default region name [None]: ap-northeast-1
Default output format [None]:
```

### 7. Secrets Manager からパスワードを取得してみる

```bash
aws secretsmanager get-secret-value --secret-id SampleTextSecret
```

### 8. Secrets Manager から取得したパスワードを環境変数に入れて MySQL に接続してみる

```bash
vim connectMySQl.sh
```
```bash
secret=$(aws secretsmanager get-secret-value --secret-id <シークレットID> | jq .SecretString | jq fromjson)
user=$(echo $secret | jq -r .username)
password=$(echo $secret | jq -r .password)
endpoint=$(echo $secret | jq -r .host)
port=$(echo $secret | jq -r .port)
mysql -h $endpoint -u $user -P $port -p$password
```
```bash
sudo chmod +x connectMySQL.sh
```
```bash
sh connectMySQL.sh

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

### 9. 取得したパスワードの値を確認する

```bash
secret=$(aws secretsmanager get-secret-value --secret-id <シークレットID> | jq .SecretString | jq fromjson)
user=$(echo $secret | jq -r .username)
password=$(echo $secret | jq -r .password)
endpoint=$(echo $secret | jq -r .host)
port=$(echo $secret | jq -r .port)

echo $password
*******

```

### 10. パスワードをローテーションして MySQL に接続する
- Secrets Manager のコンソールで [すぐにシークレットをローテーションさせる] をクリック
- EC2 で手順 [9. 取得したパスワードの値を確認する] を再度実行してみる
- connectMySQL.sh を実行して MySQL にアクセスできる事を確認する


# Note

- Secrets Manager は手動で作成します。
- Secrets Manager 作成時の Lambda から Security Group を外すか、Lambda を削除しないと terraform destory で失敗します。
