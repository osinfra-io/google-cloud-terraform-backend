# Local Values
# https://www.terraform.io/language/values/locals

locals {
  # Flatten Function
  # https://developer.hashicorp.com/terraform/language/functions/flatten

  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.

  folder_ids = flatten([
    for k, f in local.folders : [
      for folder_ids in f.folder_ids : {
        name       = k
        folder_ids = folder_ids
      }
    ]
  ])

  iam_members = flatten([
    for k, f in local.folders : [
      for repos in f.github_repos : {
        name = k
        repo = repos
      }
    ]
  ])

  # Please keep this map in alphabetical order

  folders = {
    "backend" = {
      folder_ids   = ["582566605193"]
      github_repos = ["google-cloud-terraform-backend"]
    }

    "identity" = {
      folder_ids   = ["156062445047"]
      github_repos = ["google-cloud-workload-identity"]
    }

    "kitchen" = {
      folder_ids = ["155411168404"]
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
