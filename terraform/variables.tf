/*
* リージョン
*/

# さくらのクラウドのゾーン
variable "region" {
    default = "tk1v"
}

/*
* データソースの取得
*/

# DebianのOSアーカイブ情報
data sakuracloud_archive "debian" {
    os_type = "debian"
}

/*
* SSHキー情報
*/

# さくらのクラウドに登録済みのSSHキー情報
data sakuracloud_ssh_key "main" {
  filter = {
    name = "Name"
    values = [
      "root_key",
    ]
  }
}
