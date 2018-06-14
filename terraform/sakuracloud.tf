provider sakuracloud {
  zone            = "tk1v"
  use_marker_tags = true
}

data sakuracloud_archive "debian" {
  os_type = "debian"
}

data sakuracloud_archive "vyos" {
  os_type = "vyos"
}

resource sakuracloud_ssh_key "main" {
  name       = "main"
  public_key = "${file("~/.ssh/dummy.pub")}"
}

resource sakuracloud_ssh_key "wate" {
  name       = "wate"
  public_key = "${file("~/.ssh/dummy.pub")}"
}

resource sakuracloud_ssh_key "223n" {
  name       = "223n"
  public_key = "${file("~/.ssh/dummy.pub")}"
}

resource sakuracloud_ssh_key "sperkbird" {
  name       = "sperkbird"
  public_key = "${file("~/.ssh/dummy.pub")}"
}

resource sakuracloud_ssh_key "nogajun" {
  name       = "nogajun"
  public_key = "${file("~/.ssh/dummy.pub")}"
}

resource sakuracloud_disk "web" {
  name              = "web"
  plan              = "ssd"
  size              = "20"
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }
}

resource sakuracloud_server "web" {
  name            = "web"
  disks           = ["${sakuracloud_disk.web.id}"]
  core            = 1
  memory          = 1
  nic             = "shared"
  additional_nics = ["${sakuracloud_switch.main.id}"]
}

resource sakuracloud_switch "main" {
  name = "switch"
}

resource sakuracloud_disk "database" {
  name              = "database"
  plan              = "ssd"
  size              = "20"
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }
}

resource sakuracloud_disk "database_storage" {
  name = "database_storage"
  plan = "ssd"
  size = 20
}

resource sakuracloud_server "database" {
  name = "database"

  disks = [
    "${sakuracloud_disk.database.id}",
    "${sakuracloud_disk.database_storage.id}",
  ]

  core        = 1
  memory      = 2
  nic         = "${sakuracloud_switch.main.id}"
  ipaddress   = "192.168.1.100"
  gateway     = "192.168.1.50"
  nw_mask_len = 24
}

resource sakuracloud_disk "influxdb" {
  name              = "influxdb"
  plan              = "ssd"
  size              = "20"
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }
}

resource sakuracloud_server "influxdb" {
  name        = "influxdb"
  disks       = ["${sakuracloud_disk.influxdb.id}"]
  core        = 2
  memory      = 2
  nic         = "${sakuracloud_switch.main.id}"
  ipaddress   = "192.168.1.110"
  gateway     = "192.168.1.50"
  nw_mask_len = 24
}

resource sakuracloud_disk "grafana" {
  name              = "grafana"
  plan              = "ssd"
  size              = "20"
  source_archive_id = "${data.sakuracloud_archive.debian.id}"
  ssh_key_ids       = ["${sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }
}

resource sakuracloud_server "grafana" {
  name            = "grafana"
  disks           = ["${sakuracloud_disk.grafana.id}"]
  core            = 1
  memory          = 1
  nic             = "shared"
  additional_nics = ["${sakuracloud_switch.main.id}"]
}

resource sakuracloud_disk "vyos" {
  name              = "vyos"
  plan              = "ssd"
  size              = "20"
  source_archive_id = "${data.sakuracloud_archive.vyos.id}"
  ssh_key_ids       = ["${sakuracloud_ssh_key.main.id}"]
  disable_pw_auth   = true

  lifecycle {
    ignore_changes = ["source_archive_id"]
  }
}

resource sakuracloud_server "vyos" {
  name            = "vyos"
  disks           = ["${sakuracloud_disk.vyos.id}"]
  core            = 1
  memory          = 1
  nic             = "shared"
  additional_nics = ["${sakuracloud_switch.main.id}"]
}

resource sakuracloud_nfs "storage" {
  name        = "nfs"
  description = "storage"
  switch_id   = "${sakuracloud_switch.main.id}"
  plan        = "100"
  ipaddress   = "192.168.1.200"
  nw_mask_len = 24
}
