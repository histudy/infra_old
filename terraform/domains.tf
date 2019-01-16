resource cloudflare_record "at" {
  domain = "histudy.jp"
  name   = "@"
  value  = "133.223.7.42"
  type   = "A"
}

resource cloudflare_record "www" {
  domain = "histudy.jp"
  name   = "www"
  value  = "133.223.7.42"
  type   = "A"
}

resource cloudflare_record "mail_primary" {
  domain = "histudy.jp"
  name   = "mail"
  type   = "NS"
  value  = "ns1.dns.ne.jp"
}

resource cloudflare_record "mail_secondary" {
  domain = "histudy.jp"
  name   = "mail"
  type   = "NS"
  value  = "ns2.dns.ne.jp"
}
