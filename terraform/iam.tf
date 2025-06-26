resource "google_cloud_run_v2_service_iam_member" "cloud_run_vpc_terraform_sample_backend_iam_member" {
  name   = google_cloud_run_v2_service.cloud_run_vpc_terraform_sample_backend.name
  role   = "roles/run.invoker"
  member = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "cloud_run_vpc_terraform_sample_frontend_iam_member" {
  name   = google_cloud_run_v2_service.cloud_run_vpc_terraform_sample_frontend.name
  role   = "roles/run.invoker"
  member = "allUsers"
}
