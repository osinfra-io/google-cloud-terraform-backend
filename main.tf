terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {

    # Google Cloud Platform Provider
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }
  }
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

# Google Storage Bucket Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-storage-bucket

module "storage_bucket" {
  source = "git@github.com:osinfra-io/terraform-google-storage-bucket.git"

  default_kms_key_name = google_kms_crypto_key.terraform_state.id

  labels = {
    "cost-center" = "x001",
    "environment" = var.env,
    "system"      = "terraform",
    "team"        = "shared"
  }

  location = "us"
  name     = "state"
  project  = module.project.project_id
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

  lifecycle {
    prevent_destroy = true
  }
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
