# Local Values
# https://www.terraform.io/language/values/locals

locals {

  # Please keep this map in alphabetical order.

  folders = {
    "plt-lz-backend" = {
      folder_ids = var.environment == "sb" ? [
        "515753002772"
        ] : var.environment == "prod" ? [
        "131486843041"
        ] : [
        "574432336767"
      ]
      github_repositories = ["google-cloud-terraform-backend"]
    }

    "plt-gh-organization" = {
      folder_ids          = []
      github_repositories = ["github-organization-management"]
    }

    "plt-lz-hierarchy" = {

      # The service account used to create the folder hierarchy will need to be added
      # to the Groups Admins role in the Google Workspace Admin Console.

      folder_ids          = []
      github_repositories = ["google-cloud-hierarchy"]
    }

    "plt-lz-identity" = {
      folder_ids = var.environment == "sb" ? [
        "267179923152"
        ] : var.environment == "prod" ? [
        "679274494921"
        ] : [
        "8288220956"
      ]
      github_repositories = ["google-cloud-workload-identity"]
    }

    "plt-lz-testing" = {
      folder_ids = var.environment == "sb" ? [
        "1069400145815"
      ] : var.environment == "prod" ? [
        "642644757390"
        ] : [
        "1094321749831"
      ]
      github_repositories = [
        "github-terraform-gcp-called-workflows",
        "google-cloud-kitchen-terraform",
        "terraform-google-cloud-dns",
        "terraform-google-cloud-nat",
        "terraform-google-cloud-sql",
        "terraform-google-kubernetes-engine-autopilot",
        "terraform-google-project",
        "terraform-google-storage-bucket",
        "terraform-google-subnet",
        "terraform-google-vpc"
      ]
    }

    "plt-lz-audit" = {
      folder_ids = var.environment == "sb" ? [
        "390812006260"
        ] : var.environment == "prod" ? [
        "606239917687"
        ] : [
        "988946273293"
      ]
      github_repositories = ["google-cloud-audit-logging"]
    }
  }

  project_services = toset([
    "cloudbilling.googleapis.com",
    "cloudidentity.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "serviceusage.googleapis.com"
  ])

  # Flatten Function
  # https://developer.hashicorp.com/terraform/language/functions/flatten

  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.


  folder_ids = { for folder_id in flatten([

    # This will iterate over the folders map and return a list of maps
    # based of the folder_ids that includes the name key.

    for folder_key, name in local.folders : [
      for folder_id in name.folder_ids : {
        folder_id = folder_id
        name      = folder_key
      }
    ]
  ]) : folder_id.folder_id => folder_id }


  github_repositories = { for folder_id in flatten([

    # This will iterate over the folders map and return a list of maps
    # based of the github_repositories that includes the name key.

    for folder_key, name in local.folders : [
      for repository in name.github_repositories : {
        name       = folder_key
        repository = repository
      }
    ]
  ]) : folder_id.repository => folder_id }
}
