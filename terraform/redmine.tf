/*
* Redmine構築用Terraform設定ファイル
*/

# サーバーの台数
variable "redmine_count" {
    default = 1
}

# サーバーの仮想CPUコア数
variable "redmine_cpu" {
    default = 3
}

# サーバーのメモリ数
variable "redmine_memory" {
    default = 5
}

# サーバーのストレージサイズ
variable "redmine_capacity" {
    default = 40
}

# サーバーのプライベートIPアドレス開始位置
variable "redmine_private_iprange_offset" {
    default = 50
}

resource sakuracloud_disk "redmine" {
    name              = "redmine-${count.index + 1}"
    count             = "${var.redmine_count}"
    size              = "${var.redmine_capacity}"
    source_archive_id = "${data.sakuracloud_archive.debian.id}"
    ssh_key_ids       = ["${data.sakuracloud_ssh_key.main.id}"]
    disable_pw_auth   = true
    tags = [
        "backup_hour_2",
        "redmine",
    ]
}

resource sakuracloud_server "redmine" {
    name = "redmine-${count.index + 1}"
    count = "${var.redmine_count}"
    core = "${var.redmine_cpu}"
    memory = "${var.redmine_memory}"
    disks = "${element(sakuracloud_disk.redmine.*.id, count.index)}"
}

output redmine_ipaddresses {
    value = "${sakuracloud_server.redmine.*.ipaddress}"
}
