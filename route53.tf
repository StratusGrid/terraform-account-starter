resource "aws_route53_zone" "main" {
  name = "chrissmithtesterxya123.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.chrissmithtesterxya123.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.chrissmithtesterxya123.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}

resource "aws_route53_zone" "qa" {
  name = "qa.chrissmithtesterxya123.com"

  tags = {
    Environment = "qa"
  }
}

resource "aws_route53_record" "qa-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "qa.chrissmithtesterxya123.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.qa.name_servers
}

resource "aws_route53_zone" "uat" {
  name = "uat.chrissmithtesterxya123.com"

  tags = {
    Environment = "uat"
  }
}

resource "aws_route53_record" "uat-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "uat.chrissmithtesterxya123.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.uat.name_servers
}