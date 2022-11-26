# Local Values
# https://www.terraform.io/language/values/locals

locals {

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
    "logging" = {
      folder_ids   = ["774841127628"]
      github_repos = ["google-cloud-logging"]
    }
    "observability" = {
      folder_ids   = ["479991724984"]
      github_repos = ["google-cloud-observability"]
    }
    "services" = {
      folder_ids   = ["435197788278"]
      github_repos = ["google-cloud-services"]
    }
    "terraform" = {
      folder_ids   = ["582566605193"]
      github_repos = ["google-cloud-terraform-backend"]
    }
    "testing" = {
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
    "identity" = {
      folder_ids   = ["863348505596"]
      github_repos = ["google-cloud-workload-identity"]
    }
  }

}
