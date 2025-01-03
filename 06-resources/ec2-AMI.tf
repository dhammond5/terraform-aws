# Ubuntu AMI ID = ami-095a8f574cb0ac0d0
# NGINX AMI ID = ami-0b2dc425776bf42c5

resource "aws_instance" "nginx_instance" {
  ami                         = "ami-0b2dc425776bf42c5"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.http_sg.id]

  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-nginx_instance"
  })

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "http_sg" {
  description = "Allow HTTP and HTTPS inbound traffic"
  name        = "http_security_group"
  vpc_id      = aws_vpc.vpc_main.id


  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-http_security_group"
  })
}


resource "aws_vpc_security_group_ingress_rule" "http_traffic" {
  security_group_id = aws_security_group.http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"


  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-https_security_group"
  })
}

resource "aws_vpc_security_group_ingress_rule" "https_traffic" {
  security_group_id = aws_security_group.http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"


  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-https_security_group"
  })
}


