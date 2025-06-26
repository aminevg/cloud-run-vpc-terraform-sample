resource "google_compute_network" "cloud_run_vpc_terraform_sample_network" {
  name                    = "cloud-run-vpc-terraform-sample-network"
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cloud_run_vpc_terraform_sample_subnetwork" {
  name                     = "cloud-run-vpc-terraform-sample-subnetwork"
  network                  = google_compute_network.cloud_run_vpc_terraform_sample_network.id
  region                   = var.region
  ip_cidr_range            = "10.0.0.0/24"
  private_ip_google_access = true
}

resource "google_dns_managed_zone" "cloud_run_vpc_terraform_sample_dns_zone" {
  name     = "cloud-run-vpc-terraform-sample-dns-zone"
  dns_name = "run.app."

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.cloud_run_vpc_terraform_sample_network.id
    }
  }
}

resource "google_dns_record_set" "cloud_run_vpc_terraform_sample_dns_record_set_a" {
  name         = "run.app."
  type         = "A"
  ttl          = 60
  managed_zone = google_dns_managed_zone.cloud_run_vpc_terraform_sample_dns_zone.name
  rrdatas      = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"] # private.googleapis.com
}

resource "google_dns_record_set" "cloud_run_vpc_terraform_sample_dns_record_set_cname" {
  name         = "*.run.app."
  type         = "CNAME"
  ttl          = 60
  managed_zone = google_dns_managed_zone.cloud_run_vpc_terraform_sample_dns_zone.name
  rrdatas      = ["run.app."]
}


