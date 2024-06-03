provider "google" {
  project     = "terraform-classroom"
  credentials = file("service-account-key/creds.json")
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "terraform_created_vm" {
  name                      = "terraform-vm"
  machine_type              = "f1-micro"
  zone                      = "us-central1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
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
  region        = "us-central1"
  network       = google_compute_network.terraform_created_network.id
}
