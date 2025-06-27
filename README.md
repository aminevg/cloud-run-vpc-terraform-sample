# Cloud Run with VPC Terraform Sample

(Gemini proofread!)

This is a sample project for deploying frontend and backend services to Google Cloud Run with direct VPC egress using Terraform.

## Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (`gcloud`)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Docker

## Setup

1. Login to Google Cloud:
   ```bash
   gcloud auth application-default login
   ```

2. Configure Terraform:
   ```bash
   cd terraform
   terraform init
   ```
3. Create a `terraform.tfvars` file in the `terraform` directory with the following content: (replace project and region with your own)
    **`terraform.tfvars`**
    ```terraform
    project = "<YOUR_GCP_PROJECT_ID>"
    region  = "<YOUR_GCP_REGION>"
    ```

## Deployment


### 1. Create Artifact Registry Repository

We first need to create the Artifact Registry to store our images. Run the following command in the `terraform` directory.

```bash
terraform apply -target=google_artifact_registry_repository.cloud_run_vpc_terraform_sample_repository
```

### 2. Build and Push Container Images

From the project root, build the frontend and backend images and push them to the Artifact Registry.

*Note: Change the image tag in `docker-compose.yml`　and `terraform/cloud-run.tf`  to update versions.*

```bash
export GCR_REGION="<YOUR_GCP_REGION>"
export GCR_PROJECT_NAME="<YOUR_GCP_PROJECT_ID>"
DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose build
docker compose push
```

> [!NOTE]
> The `DOCKER_DEFAULT_PLATFORM=linux/amd64` is specified to ensure the image is built for the correct architecture for Cloud Run.

### 3. Deploy to Cloud Run

Finally, from the `terraform` directory, deploy the service to Cloud Run and all other required resources.

```bash
terraform apply
```

## Deletion

To remove all resources created by this sample:

1.  Ensure that deletion protection is disabled on any resources in the Google Cloud Console if you have enabled it.
2.  From the `terraform` directory, run the destroy command:
    ```bash
    terraform destroy
    ```

> [!CAUTION]
> It may take a couple of hours for Cloud Run to release the IP addresses used by the service, in which case VPC subnet deletion may fail. If that happens, run the `terraform destroy` again later.
