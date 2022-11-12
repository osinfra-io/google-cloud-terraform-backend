locals {

  # This builds a map of folder_ids and the key so that permissions can be granted using a single resource with a loop.

  folder_ids = flatten([
    for k, f in local.folders : [
      for folder_ids in f.folder_ids : {
        name       = k
        folder_ids = folder_ids
      }
    ]
  ])

  # This builds a map of GitHub repo and key so that permissions can be granted using a single resource with a loop.

  iam_members = flatten([
    for k, f in local.folders : [
      for repos in f.github_repos : {
        name = k
        repo = repos
      }
    ]
  ])

  # This drives the creation of the onboarding resources. The key is used to generate names of the bucket
  # and services accounts.  In many cases the key will align with the team name. The folder_ids are used to
  # grant the service account project creator permissions to the folder. The github_repos are used to grant
  # repository permissions to the service account.

  # Please keep this file in alphabetical order

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
      github_repos = ["google-cloud-terraform"]
    }
    "identity" = {
      folder_ids   = ["863348505596"]
      github_repos = ["google-cloud-workload-identity"]
    }
  }

}
