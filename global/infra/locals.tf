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
      folder_ids   = ["75516075614"]
      github_repos = ["google-cloud-terraform-backend"]
    }

    "identity" = {
      folder_ids   = ["156062445047"]
      github_repos = ["google-cloud-workload-identity"]
    }

    "kitchen" = {
      folder_ids = ["760803226038"]
      github_repos = [
        "terraform-google-storage-bucket",
        "terraform-google-project",
        "terraform-google-kubernetes-engine",
        "terraform-google-cloud-sql",
        "terraform-google-cloud-nat",
        "terraform-google-cloud-dns",
        "terraform-google-subnet",
        "terraform-google-vpc"
      ]
    }

    "logging" = {
      folder_ids   = ["639396492924"]
      github_repos = ["google-cloud-logging"]
    }

    "observability" = {
      folder_ids   = ["553837839879"]
      github_repos = ["google-cloud-observability"]
    }

    "services" = {
      folder_ids   = ["606765401021"]
      github_repos = ["google-cloud-services"]
    }
  }
}
