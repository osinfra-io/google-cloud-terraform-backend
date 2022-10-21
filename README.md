# Google Cloud Platform - Terraform

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-terraform/actions):**

[![Infracost](https://github.com/osinfra-io/google-cloud-terraform/actions/workflows/infracost.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-terraform/actions/workflows/infracost.yml) [![Dependabot](https://github.com/osinfra-io/google-cloud-terraform/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-terraform/actions/workflows/dependabot.yml)

**[Bridgecrew](https://www.bridgecrew.cloud/projects?types=Passed&repository=osinfra-io%2Fgoogle-cloud-terraform&branch=main):**

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/google-cloud-terraform/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fgoogle-cloud-terraform&benchmark=CIS+GCP+V1.1)

## Terraform Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider_google) | 4.41.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project"></a> [project](#module_project) | git@github.com:osinfra-io/terraform-google-project | n/a |

### Resources

| Name | Type |
|------|------|
| [google_kms_crypto_key.terraform_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.terraform_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.terraform_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_storage_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing_account](#input_billing_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_cis_2_2_logging_sink_project_id"></a> [cis_2_2_logging_sink_project_id](#input_cis_2_2_logging_sink_project_id) | The CIS 2.2 logging sink benchmark project ID | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder_id](#input_folder_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input_env) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
