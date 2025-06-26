resource "google_cloud_run_v2_service" "cloud_run_vpc_terraform_sample_backend" {
  name     = "cloud-run-vpc-terraform-sample-backend"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    vpc_access {
      egress = "ALL_TRAFFIC"
      network_interfaces {
        network    = google_compute_network.cloud_run_vpc_terraform_sample_network.id
        subnetwork = google_compute_subnetwork.cloud_run_vpc_terraform_sample_subnetwork.id
      }
    }

    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.cloud_run_vpc_terraform_sample_repository.repository_id}/cloud-run-vpc-terraform-sample-backend:1"

      ports {
        container_port = 3000
      }

      env {
        name  = "BACKEND_PORT"
        value = "3000"
      }
    }
  }
}

resource "google_cloud_run_v2_service" "cloud_run_vpc_terraform_sample_frontend" {
  name     = "cloud-run-vpc-terraform-sample-frontend"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"
      network_interfaces {
        network    = google_compute_network.cloud_run_vpc_terraform_sample_network.id
        subnetwork = google_compute_subnetwork.cloud_run_vpc_terraform_sample_subnetwork.id
      }
    }

    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.cloud_run_vpc_terraform_sample_repository.repository_id}/cloud-run-vpc-terraform-sample-frontend:1"

      ports {
        container_port = 4321
      }

      env {
        name  = "BACKEND_URL"
        value = google_cloud_run_v2_service.cloud_run_vpc_terraform_sample_backend.uri
      }
    }
  }
}
