# Terraform Global Infrastructure Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.8.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project"></a> [project](#module\_project) | github.com/osinfra-io/terraform-google-project//global | v0.1.8 |
| <a name="module_terraform_state_storage_bucket"></a> [terraform\_state\_storage\_bucket](#module\_terraform\_state\_storage\_bucket) | github.com/osinfra-io/terraform-google-storage-bucket | v0.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_identity_group_membership.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership) | resource |
| [google_service_account.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [random_id.bucket](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_billing_users_group_id"></a> [billing\_users\_group\_id](#input\_billing\_users\_group\_id) | The numeric ID of the billing users group | `string` | `"03dy6vkm4a7ag9g"` | no |
| <a name="input_cis_2_2_logging_sink_project_id"></a> [cis\_2\_2\_logging\_sink\_project\_id](#input\_cis\_2\_2\_logging\_sink\_project\_id) | The CIS 2.2 logging sink benchmark project ID | `string` | n/a | yes |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Datadog API key | `string` | n/a | yes |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | Datadog APP key | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_workload_identity_pool_name"></a> [workload\_identity\_pool\_name](#input\_workload\_identity\_pool\_name) | The workload identity pool name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_actions_service_account_emails"></a> [github\_actions\_service\_account\_emails](#output\_github\_actions\_service\_account\_emails) | The GitHub Actions service account emails |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The project ID |
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | The project number |
| <a name="output_terraform_state_storage_buckets"></a> [terraform\_state\_storage\_buckets](#output\_terraform\_state\_storage\_buckets) | The Terraform state bucket names |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
