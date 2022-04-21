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

resource "yandex_compute_instance" "wm1" {
  name = "wm1"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
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

resource "yandex_compute_instance" "wm2" {
  name = "wm2"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
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

resource "yandex_compute_instance" "wm3" {
  name = "wm3"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      # centos 7
      image_id = "fd8p7vi5c5bbs2s5i67s"
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
    user1  = "ubuntu"
    user2  = "centos"
    host1 = join("", [yandex_compute_instance.wm1.network_interface[0].nat_ip_address])
    host2 = join("", [yandex_compute_instance.wm2.network_interface[0].nat_ip_address])
    host3 = join("", [yandex_compute_instance.wm3.network_interface[0].nat_ip_address])
  }
}

resource "local_file" "save_inventory" {
  content  = data.template_file.inventory.rendered
  filename = "./inventory"
}