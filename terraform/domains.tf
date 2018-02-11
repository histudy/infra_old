variable "ns_records" {
  default = [
    "ns1.dns.ne.jp",
    "ns2.dns.ne.jp",
  ]
}

resource cloudflare_record "at" {
  domain = "histudy.jp"
  name   = "@"
  value  = "203.104.205.229"
  type   = "A"
}

resource cloudflare_record "www" {
  domain = "histudy.jp"
  name   = "www"
  value  = "203.104.205.229"
  type   = "A"
}

resource cloudflare_record "mail" {
  domain = "histudy.jp"
  name   = "mail"
  type   = "NS"
  value  = "${var.ns_records[count.index]}"
  count  = 2
}
