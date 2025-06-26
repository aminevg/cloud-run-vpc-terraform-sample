resource "google_artifact_registry_repository" "cloud_run_vpc_terraform_sample_repository" {
  repository_id = "cloud-run-vpc-terraform-sample-repository"
  format        = "docker"
}
