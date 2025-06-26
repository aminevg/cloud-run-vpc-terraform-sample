# cloud-run-vpc-terraform-sample

## build for cloud run

* Change image tag in compose file to update versions
* Specify the architecture (linux/amd64)


```bash
export GCR_REGION=<リージョン>
export GCR_PROJECT_NAME=<プロジェクト名>
DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose build
```

## terraform

Install terraform and gcloud

```bash
cd terraform
gcloud auth application-default login
terraform init
```

Create `terraform.tvars` file

```terraform
region  = "<リージョン>"
project = "<プロジェクト名>"
```

```bash
terraform apply -target=google_artifact_registry_repository.cloud_run_vpc_terraform_sample_repository
```

```bash
export GCR_REGION=<リージョン>
export GCR_PROJECT_NAME=<プロジェクト名>
docker compose push
```

```bash
terraform apply
```

## deletion

set deletion protection to false

```bash
terraform destroy
```