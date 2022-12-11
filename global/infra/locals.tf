# Local Values
# https://www.terraform.io/language/values/locals

locals {
  # Flatten Function
  # https://developer.hashicorp.com/terraform/language/functions/flatten

  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.


  folder_ids = flatten([

    # This will iterate over the object values of the folders map and return a list of maps
    # based of the folder IDs that includes the name key.

    for folders_key, name in local.folders : [
      for folder_id in name.folder_ids : {
        name      = folders_key
        folder_id = folder_id
      }
    ]
  ])


  iam_members = flatten([

    # This will iterate over the object values of the folders map and return a list of maps
    # based of the repositories that includes the name key.

    for folders_key, name in local.folders : [
      for repo in name.github_repos : {
        name = folders_key
        repo = repo
      }
    ]
  ])

  # Please keep this map in alphabetical order

  folders = {
    "backend" = {
      folder_ids = var.env == "sb" ? [
        "472942506775"
        ] : var.env == "prod" ? [
        "696376416743"
        ] : [
        "304873708680"
      ]
      github_repos = ["google-cloud-terraform-backend"]
    }

    "identity" = {
      folder_ids = var.env == "sb" ? [
        "766336877343"
        ] : var.env == "prod" ? [
        "12296811897"
        ] : [
        "885562390425"
      ]
      github_repos = ["google-cloud-workload-identity"]
    }

    "kitchen" = {
      folder_ids = var.env == "sb" ? [
        "773178458475"
      ] : []

      github_repos = [
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

    "logging" = {
      folder_ids = var.env == "sb" ? [
        "549027470269"
        ] : var.env == "prod" ? [
        "2807385679"
        ] : [
        "382807484860"
      ]
      github_repos = ["google-cloud-logging"]
    }

    "observability" = {
      folder_ids = var.env == "sb" ? [
        "386339487978"
        ] : var.env == "prod" ? [
        "175423741158"
        ] : [
        "28730462134"
      ]
      github_repos = ["google-cloud-observability"]
    }

    "services" = {
      folder_ids = var.env == "sb" ? [
        "214868359784"
        ] : var.env == "prod" ? [
        "66049090007"
        ] : [
        "588745651780"
      ]
      github_repos = ["google-cloud-services"]
    }
  }
}
