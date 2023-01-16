# Local Values
# https://www.terraform.io/language/values/locals

locals {

  # Please keep this map in alphabetical order.

  folders = {
    "backend" = {
      folder_ids = var.environment == "sb" ? [
        "704512602403"
        ] : var.environment == "prod" ? [
        "197060106393"
        ] : [
        "41386811783"
      ]
      github_repositories = ["google-cloud-terraform-backend"]
    }

    "organization" = {
      folder_ids          = []
      github_repositories = ["github-organization-management"]
    }

    "hierarchy" = {

      # The service account used to create the folder hierarchy will need to be added
      # to the Groups Admins role in the Google Workspace Admin Console.

      folder_ids          = []
      github_repositories = ["google-cloud-hierarchy"]
    }

    "identity" = {
      folder_ids = var.environment == "sb" ? [
        "544336345061"
        ] : var.environment == "prod" ? [
        "310936952825"
        ] : [
        "553241873012"
      ]
      github_repositories = ["google-cloud-workload-identity"]
    }

    "testing" = {
      folder_ids = var.environment == "sb" ? [
        "21945465219"
      ] : []

      github_repositories = [
        "github-terraform-gcp-called-workflows",
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
        "1041886242358"
        ] : var.environment == "prod" ? [
        "450157769308"
        ] : [
        "859475012086"
      ]
      github_repositories = ["google-cloud-audit-logging"]
    }

    "observability" = {
      folder_ids = var.environment == "sb" ? [
        "48432288917"
        ] : var.environment == "prod" ? [
        "711896275617"
        ] : [
        "213944643261"
      ]
      github_repositories = ["google-cloud-observability"]
    }

    "services" = {
      folder_ids = var.environment == "sb" ? [
        "1040290457625"
        ] : var.environment == "prod" ? [
        "93071714283"
        ] : [
        "212956865142"
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
