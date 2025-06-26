terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.41.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}
