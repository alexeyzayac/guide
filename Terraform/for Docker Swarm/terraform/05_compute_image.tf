# 05_compute_image.tf

locals {
  image_id = "fd83c1pf8uf99qhppnvb"
}

data "yandex_compute_image" "toolbox" {
  #image_id = local.image_id
  family = "ubuntu-2404-lts-oslogin"
}