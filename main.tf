terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

# Google Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs

provider "google" {
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "project" {
  source = "git@github.com:osinfra-io/terraform-google-project"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  cost_center                     = "x001"
  env                             = var.env
  folder_id                       = var.folder_id

  labels = {
    "environment" = var.env,
    "system"      = "terraform",
    "team"        = "shared"
  }

  prefix = "shared"
  system = "terraform"
}

# KMS CryptoKey Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key

resource "google_kms_crypto_key" "terraform_state" {
  key_ring = google_kms_key_ring.terraform_state.id

  labels = {
    "cost-center" = "x001",
    "environment" = var.env,
    "system"      = "terraform",
    "team"        = "shared"
  }

  name            = "terraform-state"
  rotation_period = "100000s"

  depends_on = [
    google_project_service.this
  ]
}

# KMS Crypto Key IAM Policy Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_kms_crypto_key_iam#google_kms_crypto_key_iam_member

resource "google_kms_crypto_key_iam_member" "terraform_state" {
  crypto_key_id = google_kms_crypto_key.terraform_state.id
  member        = "serviceAccount:service-${module.project.project_number}@gs-project-accounts.iam.gserviceaccount.com"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

# KeyRing Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring

resource "google_kms_key_ring" "terraform_state" {
  location = "us"
  name     = "terraform-state-key-ring"
  project  = module.project.project_id

  depends_on = [
    google_project_service.this
  ]
}

# Project Service Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service

resource "google_project_service" "this" {
  for_each = toset(
    [
      "cloudkms.googleapis.com",
    ]
  )

  project = module.project.project_id
  service = each.key

  disable_on_destroy = false
}

# Storage Bucket Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

resource "google_storage_bucket" "terraform_state" {

  # checkov:skip=CKV_GCP_62: In most cases, Cloud Audit Logs is the recommended method for generating logs that track API operations
  # performed in Cloud Storage.

  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_state.id
  }

  force_destroy = false

  labels = {
    "cost-center" = "x001",
    "environment" = var.env,
    "system"      = "terraform",
    "team"        = "shared"
  }

  location = "us"

  name    = "${module.project.project_id}-terraform-state"
  project = module.project.project_id

  # Generally, using uniform bucket-level access is recommended, because it unifies and simplifies how you grant access
  # to your Cloud Storage resources.

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
