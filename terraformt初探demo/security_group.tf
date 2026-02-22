# ============================================================
# Security Group Configuration
# ============================================================

resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.main.id

  # =========================================================
  # TODO(human): Define your ingress (inbound) rules below
  # =========================================================
  #
  # Think about:
  # - What ports does your EC2 need to accept traffic on?
  # - Who should be allowed to access these ports?
  # - Security best practice: principle of least privilege
  #
  # Example ingress block structure:
  #
  # ingress {
  #   description = "Description of this rule"
  #   from_port   = <port_number>
  #   to_port     = <port_number>
  #   protocol    = "tcp"
  #   cidr_blocks = ["x.x.x.x/x"]
  # }
  #
  # Common ports to consider:
  # - 22 (SSH)
  # - 80 (HTTP)
  # - 443 (HTTPS)
  #
  # YOUR CODE HERE:
  # =========================================================
  ingress {
    description = "Allow SSH from allowed CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }
  # HTTP - 開放給全世界（網站需要）
  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # =========================================================
  # Egress (outbound) rules - allowing all outbound traffic
  # =========================================================
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}
