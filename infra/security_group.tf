
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group" "custom_sg" {
  name        = "${var.name}_allow_inbound_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.this.id
  tags = {
    "Name" = "${var.name}-lb-sg"
  }
}

resource "aws_security_group_rule" "ingress_load_balancer" {
  description       = "allow traffic into the load balancer"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.custom_sg.id
}

resource "aws_security_group_rule" "egress_load_balancer" {
  description       = "allow traffic to reach outside the vpc"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.custom_sg.id
}
resource "aws_security_group" "container_sg" {
  name        = "${var.name}_container_allow_inbound_access"
  description = "allow inbound traffic to the containers"
  vpc_id      = aws_vpc.this.id
  tags = {
    "Name" = "${var.name}-container-sg"
  }
}

resource "aws_security_group_rule" "ingress_container" {
  description              = "allow traffic into the containers from the vpc"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.custom_sg.id
  security_group_id        = aws_security_group.container_sg.id
}

resource "aws_security_group_rule" "egress_container" {
  description       = "allow traffic to reach the vpc from the container"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.container_sg.id
}

resource "aws_security_group" "endpoint_sg" {
  name        = "endpoint_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.this.id
  tags = {
    "Name" = "${var.name}-endpoint-sg"
  }
}

resource "aws_security_group_rule" "ingress_vpc_endpoint" {
  description       = "Enable access for the endpoints."
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.this.cidr_block]
  security_group_id = aws_security_group.endpoint_sg.id
}