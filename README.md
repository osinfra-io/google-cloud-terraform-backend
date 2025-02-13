# <img align="left" width="55" height="45" src="https://github.com/osinfra-io/google-cloud-terraform-backend/assets/1610100/728bce8c-4c5a-471d-bf0e-36835d7796ff"> Google Cloud Platform - Terraform Backend

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-terraform-backend/actions):**

[![Dependabot](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/9c3ee651-0722-41fc-8486-1a44637bd381/branch/af4debc9-dbda-4648-97ba-42a664cd3856)](https://dashboard.infracost.io/org/osinfra-io/repos/9c3ee651-0722-41fc-8486-1a44637bd381?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## 📄 Repository Description

This repository builds the Terraform backend for state management. Terraform uses persisted state data to keep track of the resources it manages. Most non-trivial Terraform configurations use a backend to store state remotely. This lets multiple people access the state data and work together on that collection of infrastructure resources. This repository aligns with our [Google Cloud landing zone platform](https://docs.osinfra.io/google-cloud-platform/landing-zone) design. A landing zone should be a prerequisite to deploying enterprise workloads in a cloud environment.

## 🏭 Platform Information

- Documentation: [docs.osinfra.io](https://docs.osinfra.io/product-guides/google-cloud-platform/landing-zone/google-cloud-terraform-backend)
- Service Interfaces: [github.com](https://github.com/osinfra-io/google-cloud-terraform-backend/issues/new/choose)

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [checkov](https://github.com/bridgecrewio/checkov)
- [infracost](https://github.com/infracost/infracost)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [storage buckets](https://cloud.google.com/storage/docs/key-terms#buckets)
- [cloud identity groups](https://cloud.google.com/identity/docs/concepts/groups)
- [service accounts](https://cloud.google.com/iam/docs/service-accounts)
- [iam roles](https://cloud.google.com/iam/docs/understanding-roles)
- [terraform backend type gcs](https://developer.hashicorp.com/terraform/language/settings/backends/gcs)

### 📓 Terraform Documentation

<!-- BEGIN_TF_DOCS -->
#### Providers

| Name | Version |
|------|---------|
| google | 6.20.0 |
| random | 3.6.3 |

#### Modules

| Name | Source | Version |
|------|--------|---------|
| datadog | github.com/osinfra-io/terraform-datadog-google-integration | v0.3.3 |
| helpers | github.com/osinfra-io/terraform-core-helpers//root | v0.1.2 |
| project | github.com/osinfra-io/terraform-google-project | v0.4.5 |
| terraform\_state\_storage\_bucket | github.com/osinfra-io/terraform-google-storage-bucket | v0.2.0 |

#### Resources

| Name | Type |
|------|------|
| [google_cloud_identity_group_membership.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership) | resource |
| [google_service_account.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [random_id.bucket](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_users\_group\_id | The numeric ID of the billing users group | `string` | `"03dy6vkm4a7ag9g"` | no |
| datadog\_api\_key | Datadog API key | `string` | n/a | yes |
| datadog\_app\_key | Datadog APP key | `string` | n/a | yes |
| datadog\_enable | Enable Datadog integration | `bool` | `false` | no |
| project\_billing\_account | The alphanumeric ID of the billing account this project belongs to | `string` | `"01C550-A2C86B-B8F16B"` | no |
| project\_cis\_2\_2\_logging\_sink\_project\_id | The CIS 2.2 logging sink benchmark project ID | `string` | n/a | yes |
| project\_folder\_id | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| project\_monthly\_budget\_amount | The monthly budget amount in USD to set for the project | `number` | `5` | no |
| workload\_identity\_pool\_name | The workload identity pool name | `string` | n/a | yes |

#### Outputs

| Name | Description |
|------|-------------|
| github\_actions\_service\_account\_emails | The GitHub Actions service account emails |
| project\_id | The project ID |
| project\_number | The project number |
| terraform\_state\_storage\_buckets | The Terraform state bucket names |
<!-- END_TF_DOCS -->
