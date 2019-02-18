module "static-hosting" {
  source = "./r53-acm-s3-cfd"

  dns_zone = "mccartney.ie"
  site_fqdn = "www.mccartney.ie"
}
