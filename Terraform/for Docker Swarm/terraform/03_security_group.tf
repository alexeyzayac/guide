# 03_security_group.tf

# Настройка сервера
resource "yandex_vpc_security_group" "cluster_sg" {
  name       = "cluster-sg-${var.flow}"
  network_id = yandex_vpc_network.develop.id

  ingress {
    description    = "Any incoming"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  egress {
    description    = "Any outgoing"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
