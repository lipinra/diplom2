# создаем вм1
resource "yandex_compute_instance" "nginx-1" {
  name                      = "nginx-1"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"
  hostname                  = "nginx-1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }
  
  metadata = {
    user-data = file("./metadata.yaml")
  }

}

# создаем вм2
resource "yandex_compute_instance" "nginx-2" {
  name                      = "nginx-2"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"
  hostname                  = "nginx-2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-2.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }
  
  metadata = {
    user-data = file("./metadata.yaml")
  }
  
}

# создаем вм3 - zabbix
resource "yandex_compute_instance" "zabbix" {
  name                      = "zabbix"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-c"
  hostname                  = "zabbix"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-4.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id, yandex_vpc_security_group.zabbix-sg.id]
  }
  
  metadata = {
    user-data = file("./metadata.yaml")
  }
}

# создаем вм4 - elastic
resource "yandex_compute_instance" "elastic" {
  name                      = "elastic"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-c"
  hostname                  = "elastic"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-3.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }
  
  metadata = {
    user-data = file("./metadata.yaml")
  }
}

# создаем вм5 - kibana
resource "yandex_compute_instance" "kibana" {
  name                      = "kibana"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-c"
  hostname                  = "kibana"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-4.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id, yandex_vpc_security_group.kibana-sg.id]
  }
  
  metadata = {
    user-data = file("./metadata.yaml")
  }

}

# создаем бастионный хост
resource "yandex_compute_instance" "bastion" {
  name                      = "bastion"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-c"
  hostname                  = "bastion"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-4.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.bastion-sg.id]
  }

  metadata = {
    user-data = file("./metadata.yaml")
  }
  
}