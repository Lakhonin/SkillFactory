terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.71.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = "b1gavf75ukmkdkq5pc67"
  folder_id                = "b1gtrnt5bah9u3n16tt8"
  zone                     = "ru-central1-a"
}

resource "yandex_compute_instance" "b12" {
  name = "b12"
  resources {
    cores         = 2
    memory        = 8
    core_fraction = 100
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      # ubuntu 20-04
      image_id = "fd8mfc6omiki5govl68h"
      size     = 20
    }
  }
  network_interface {
    subnet_id = "e9bhe2om22dbr4c18tfu"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

data "template_file" "inventory" {
  template = file("./inventory.tpl")

  vars = {
    user  = "ubuntu"
    host1 = join("", [yandex_compute_instance.b12.network_interface[0].nat_ip_address])
  }
}

resource "local_file" "save_inventory" {
  content  = data.template_file.inventory.rendered
  filename = "./inventory"
}