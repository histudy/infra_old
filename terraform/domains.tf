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

resource cloudflare_record "postmaster_tool_auth" {
  domain = "histudy.jp"
  name   = "@"
  type   = "TXT"
  ttl    = "86400"
  value  = "google-site-verification=7PjGDFZDUN-c85npu9gYvkj1DN0SVGnRBVhQQDDv5nY"
}

resource cloudflare_record "vyos" {
  domain = "histudy.jp"
  name   = "vyos"
  value  = "133.223.1.217"
  type   = "A"
}
