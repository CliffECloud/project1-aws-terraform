resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.project1.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private_1.id,
    aws_route_table.private_2.id
  ]

  tags = {
    Name = "${var.project_name}-ha-web-vpce-s3"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.project1.id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.vpce.id
  ]
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.project1.id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  security_group_ids = [
    aws_security_group.vpce.id
  ]
}

