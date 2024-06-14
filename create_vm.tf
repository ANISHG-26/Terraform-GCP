provider "google" {
  project     = var.project
  credentials = file(var.credentials_files)
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "terraform_created_vm" {
  name                      = var.vm_params.name
  machine_type              = var.vm_params.machine_type
  zone                      = var.vm_params.zone
  allow_stopping_for_update = var.vm_params.allow_stopping_for_update

  boot_disk {
    initialize_params {
      image = var.os_image
    }
  }

  network_interface {
    network    = google_compute_network.terraform_created_network.self_link
    subnetwork = google_compute_subnetwork.terraform_created_subnet.self_link
    access_config {
      //necessary (left empty)
    }
  }
}

resource "google_compute_network" "terraform_created_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform_created_subnet" {
  name          = "terraform-subnet"
  ip_cidr_range = "10.20.0.0/16"
  region        = var.region
  network       = google_compute_network.terraform_created_network.id
}
