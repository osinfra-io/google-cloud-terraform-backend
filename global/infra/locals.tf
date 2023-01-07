# Local Values
# https://www.terraform.io/language/values/locals

locals {

  # Please keep this map in alphabetical order

  folders = {
    "backend" = {
      folder_ids = var.environment == "sb" ? [
        "472942506775"
        ] : var.environment == "prod" ? [
        "696376416743"
        ] : [
        "304873708680"
      ]
      github_repositories = ["google-cloud-terraform-backend"]
    }

    "identity" = {
      folder_ids = var.environment == "sb" ? [
        "766336877343"
        ] : var.environment == "prod" ? [
        "12296811897"
        ] : [
        "885562390425"
      ]
      github_repositories = ["google-cloud-workload-identity"]
    }

    "kitchen" = {
      folder_ids = var.environment == "sb" ? [
        "773178458475"
      ] : []

      github_repositories = [
        "google-cloud-kitchen-terraform",
        "terraform-google-cloud-dns",
        "terraform-google-cloud-nat",
        "terraform-google-cloud-sql",
        "terraform-google-kubernetes-engine",
        "terraform-google-project",
        "terraform-google-storage-bucket",
        "terraform-google-subnet",
        "terraform-google-vpc"
      ]
    }

    "audit" = {
      folder_ids = var.environment == "sb" ? [
        "549027470269"
        ] : var.environment == "prod" ? [
        "2807385679"
        ] : [
        "382807484860"
      ]
      github_repositories = ["google-cloud-audit-logging"]
    }

    "observability" = {
      folder_ids = var.environment == "sb" ? [
        "386339487978"
        ] : var.environment == "prod" ? [
        "175423741158"
        ] : [
        "28730462134"
      ]
      github_repositories = ["google-cloud-observability"]
    }

    "services" = {
      folder_ids = var.environment == "sb" ? [
        "214868359784"
        ] : var.environment == "prod" ? [
        "66049090007"
        ] : [
        "588745651780"
      ]
      github_repositories = ["google-cloud-services"]
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
