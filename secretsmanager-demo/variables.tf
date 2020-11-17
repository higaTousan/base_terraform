#######################
## Variable Settings ##
#######################

# Base
variable "environment" {
    description = "環境特有のプレフィックス(個人名 / STG もしくは PRD など)"
}
variable "region" {
   description = "構築するリージョン"
   default = "ap-northeast-1"
}

# VPC
variable "vpc_name" {
    description = "VPC 名。Name タグに付きます"
}
variable "vpc_cidr" {
    description = "ネットワーク IP レンジ"
}
variable "enable_ipv6" {
    description = "IPv6の使用有無"
    default = "true"
}

# Subnet
variable "subnet_cidr_1" {
    description = "Subnet1 のネットワーク IP レンジ"
}
variable "subnet_cidr_2" {
    description = "Subnet2 のネットワーク IP レンジ"
}
variable "subnet_cidr_3" {
    description = "Subnet3 のネットワーク IP レンジ"
}
variable "subnet_cidr_4" {
    description = "Subnet4 のネットワーク IP レンジ"
}

variable "subnet_name_1" {
    description = "Subnet1 の名前。 Name タグに付きます。"
}
variable "subnet_name_2" {
    description = "Subnet2 の名前。 Name タグに付きます。"
}
variable "subnet_name_3" {
    description = "Subnet3 の名前。 Name タグに付きます。"
}
variable "subnet_name_4" {
    description = "Subnet4 の名前。 Name タグに付きます。"
}

# EC2
variable "ec2_instance_type" {
    description = "EC2 のインスタンスタイプ"
}
variable "ec2_keyname" {
    description = "EC2 に割り当てるキーペア名"
}
variable "ec2_sg_ssh_allow_ip" {
    description = "EC2 SSH を許可する IPアドレス"
}
variable "ec2_sg_name" {
    description = "EC2 にアタッチする SG 名"
}
variable "ec2_role_name" {
    description = "EC2 にアタッチするロール名"
}

# RDS
variable "db_storage_size" {
    description = "RDS に割り当てるストレージサイズ"
}
variable "db_storage_type" {
    description = "RDS に割り当てるストレージのタイプ"
}
variable "db_engine" {
    description = "RDS の種類"
}
variable "db_engine_version" {
   description = "RDS のバージョン"
}
variable "db_instance_class" {
    description = "RDS のインスタンスタイプ"
}
variable "db_name" {
    description = "データベース名"
}
variable "db_username" {
    description = "データベースログインアカウント名"
}
variable "db_password" {
    description = "データベースログインパスワード"
}
variable "db_parameter_group_name" {
    description = "RDS のパラメータグループ名"
}
variable "db_subnet_group_name" {
    description = "RDS のサブネットグループ名"
}
variable "db_sg_name" {
    description = "RDS にアタッチする SG 名"
}
variable "db_port" {
    description = "RDS が使う Port"
}