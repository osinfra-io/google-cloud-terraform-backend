terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {

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

# The google_cloud_identity_group resource requires this if you are using User ADCs (Application Default Credentials).
# Your account must have the serviceusage.services.use permission on the billing_project you defined.
# The following APIs must be enabled on the billing_project:
# - cloudresourcemanager.googleapis.com
# - cloudidentity.googleapis.com

provider "google" {
  billing_project       = var.billing_project
  user_project_override = true
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "project" {
  source = "github.com/osinfra-io/terraform-google-project"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  cost_center                     = "x001"
  env                             = var.env
  folder_id                       = var.folder_id

  labels = {
    "environment" = var.env
    "system"      = "terraform"
    "team"        = "shared"
  }

  prefix            = "shared"
  random_project_id = var.random_project_id
  system            = "terraform"
}

# Google Storage Bucket Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-storage-bucket

module "terraform_state_storage_bucket" {
  source   = "github.com/osinfra-io/terraform-google-storage-bucket"
  for_each = local.folders

  labels = {
    "cost-center" = "x001"
    "environment" = var.env
    "system"      = "terraform"
    "team"        = each.key
  }

  location = "us"
  name     = each.key
  project  = module.project.project_id
}

# Google Identity Group Membership
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_identity_group_membership

resource "google_cloud_identity_group_membership" "github_actions" {
  for_each = local.folders

  # Use the following gcloud command to figure out the group_id
  # gcloud identity groups search --organization=osinfra.io --labels="cloudidentity.googleapis.com/groups.discussion_forum"

  # This should be the group_id for the gcp-billing-users group created in the google-cloud-hierarchy repository.

  group = "groups/043ky6rz1fxeewi"

  preferred_member_key {
    id = google_service_account.github_actions[each.key].email
  }

  roles {
    name = "MEMBER"
  }

  depends_on = [
    google_project_service.this
  ]
}

# Google Folder IAM Member
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder_iam#google_folder_iam_member

resource "google_folder_iam_member" "github_actions" {
  for_each = local.folder_ids

  folder = "folders/${each.value.folder_id}"
  member = "serviceAccount:${google_service_account.github_actions[each.value.name].email}"
  role   = "roles/resourcemanager.projectCreator"
}

# Project Service Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service

# Any API that is going to be used by the platforms must be enabled here.

resource "google_project_service" "this" {
  for_each = local.project_services

  project = module.project.project_id
  service = each.key

  disable_on_destroy = false
}


# Google Service Account Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "github_actions" {
  for_each = local.folders

  account_id   = "${each.key}-github-actions"
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
  for_each = local.folders

  bucket = module.terraform_state_storage_bucket[each.key].name
  member = "serviceAccount:${google_service_account.github_actions[each.key].email}"
  role   = "roles/storage.objectAdmin"
}
