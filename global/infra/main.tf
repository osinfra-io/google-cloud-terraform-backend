terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {

    # Datadog Provider
    # https://registry.terraform.io/providers/DataDog/datadog/latest/docs

    datadog = {
      source = "datadog/datadog"
    }

    # Google Cloud Platform Provider
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }

    # Random Provider
    # https://www.terraform.io/docs/providers/random/index.html

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# The google_cloud_identity_group resource requires this if you are using User ADCs (Application Default Credentials).
# Your account must have the serviceusage.services.use permission on the billing_project you defined.
# The following APIs must be enabled on the billing_project:
# - cloudresourcemanager.googleapis.com
# - cloudidentity.googleapis.com

# This is only needed during bootstrapping.

# provider "google" {
#   billing_project       = var.billing_project
#   user_project_override = true
# }

# Datadog Google Cloud Platform Integration Module (osinfra.io)
# https://github.com/osinfra-io/terraform-datadog-google-integration

module "datadog" {
  source = "github.com/osinfra-io/terraform-datadog-google-integration//global?ref=v0.1.0"

  api_key         = var.datadog_api_key
  is_cspm_enabled = true
  project         = module.project.project_id
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "project" {
  source = "github.com/osinfra-io/terraform-google-project//global?ref=v0.1.3"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  cost_center                     = "x001"
  description                     = "terraform"
  environment                     = var.environment
  folder_id                       = var.folder_id

  labels = {
    env      = var.environment
    module   = "google-cloud-terraform-backend"
    platform = "google-cloud-landing-zone"
    team     = "platform-google-cloud-landing-zone"
  }

  prefix = "ptl-lz"

  services = [
    "cloudasset.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudidentity.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}

# Google Storage Bucket Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-storage-bucket

module "terraform_state_storage_bucket" {
  source   = "github.com/osinfra-io/terraform-google-storage-bucket?ref=v0.1.0"
  for_each = local.service_accounts

  labels = {
    cost-center = "x001"
    env         = var.environment
    module      = "google-cloud-terraform-backend"
    platform    = "google-cloud-landing-zone"
    team        = "platform-google-cloud-landing-zone"
  }

  location = "us"
  name     = "${each.key}-${random_id.bucket.hex}-${var.environment}"
  project  = module.project.project_id
}

# Google Identity Group Membership
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership

resource "google_cloud_identity_group_membership" "github_actions" {
  for_each = local.service_accounts

  # Use the following gcloud command to figure out the group_id
  # gcloud identity groups search --organization=osinfra.io --labels="cloudidentity.googleapis.com/groups.discussion_forum"

  # This should be the group_id for the gcp-billing-users group created in the google-cloud-hierarchy repository.

  group = "groups/${var.billing_users_group_id}"

  preferred_member_key {
    id = google_service_account.github_actions[each.key].email
  }

  roles { name = "MEMBER" }

  dynamic "roles" {
    for_each = each.key == "plt-lz-backend" ? [1] : []

    content {
      name = "MANAGER"
    }
  }

  depends_on = [
    module.project
  ]
}

# Google Service Account Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "github_actions" {
  for_each = local.service_accounts

  account_id   = "${each.key}-github"
  display_name = "Service account for GitHub Actions"
  project      = module.project.project_id
}

# Google Service Account IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam#google_service_account_iam_member

resource "google_service_account_iam_member" "github_actions" {
  for_each = local.github_repositories

  member             = "principalSet://iam.googleapis.com/${var.workload_identity_pool_name}/attribute.repository/osinfra-io/${each.value.repository}"
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.github_actions[each.value.name].id
}

# Google Storage Bucket IAM Member
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam#google_storage_bucket_iam_member

resource "google_storage_bucket_iam_member" "github_actions" {
  for_each = local.service_accounts

  bucket = module.terraform_state_storage_bucket[each.key].name
  member = "serviceAccount:${google_service_account.github_actions[each.key].email}"
  role   = "roles/storage.objectAdmin"
}

# Random Random ID Resource
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id

resource "random_id" "bucket" {
  byte_length = 2
}
