terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
}

module "project" {
  source = "git@github.com:osinfra-io/terraform-google-project"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  cost_center                     = "x001"
  env                             = var.env
  folder_id                       = var.folder_id

  labels = {
    "environment" = var.env,
    "system"      = "utils",
    "team"        = "devops"
  }

  prefix = "devops"
  system = "utils"
}

# KMS CryptoKey Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key

resource "google_kms_crypto_key" "terraform_state" {
  key_ring = google_kms_key_ring.terraform_state.id

  labels = merge(
    {
      cost-center = "x001"
    },
  )

  name            = "terraform-state"
  rotation_period = "100000s"
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
}

# Storage Bucket Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

resource "google_storage_bucket" "terraform_state" {
  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_state.id
  }

  force_destroy = false

  labels = merge(
    {
      cost-center = "x001"
    },
  )

  location = "us"

  logging {
    log_bucket        = "HARDCODE_BUCKET_NAME"
    log_object_prefix = "terraform-state-"
  }

  name    = "${module.project.project_id}-terraform-state"
  project = module.project.project_id

  retention_policy {
    retention_period = 1800
    is_locked        = false
  }

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
