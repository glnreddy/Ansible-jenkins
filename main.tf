provider "google" {
  credentials = "${file("~/credentials.json")}"
  project     = "My Project2"
  region      = "us-central1"
}

resource "google_compute_instance" "default" {
  name = "test"
  machine_type = "n1-standard-1"
  zone = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "CentOS 7"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

