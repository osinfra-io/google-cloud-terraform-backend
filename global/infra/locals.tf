# Local Values
# https://www.terraform.io/language/values/locals

locals {

  # Please keep this map in alphabetical order.

  # You can add a github_ref key to the map to specify a branch. In the following example,
  # the service account will not be able to deploy to any other environment than sb unless
  # the branch is merged into main.

  ptl_github_ref = var.environment == "sb" ? null : "refs/heads/main"

  service_accounts = {
    "plt-gh-organization" = {
      github_ref          = local.ptl_github_ref
      github_repositories = ["github-organization-management"]
    }

    "plt-lz-audit" = {
      github_ref          = local.ptl_github_ref
      github_repositories = ["google-cloud-audit-logging"]
    }

    "plt-lz-backend" = {
      # github_ref                 = local.ptl_github_ref
      github_ref                 = var.environment == "sb" ? "refs/security-hardening" : null
      github_repositories        = ["google-cloud-terraform-backend"]
      billing_user_group_manager = true
    }

    "plt-lz-hierarchy" = {

      github_ref = local.ptl_github_ref

      # The service account used to create the folder hierarchy will need to be added
      # to the Groups Admins role in the Google Workspace Admin Console.

      github_repositories = ["google-cloud-hierarchy"]
    }

    "plt-lz-identity" = {
      github_ref          = local.ptl_github_ref
      github_repositories = ["google-cloud-workload-identity"]
    }

    "plt-lz-networking" = {
      github_ref          = local.ptl_github_ref
      github_repositories = ["google-cloud-networking"]
    }

    "plt-lz-testing" = {
      github_ref = local.ptl_github_ref
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
  }

  # Flatten Function
  # https://developer.hashicorp.com/terraform/language/functions/flatten

  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.

  github_repositories = { for service_account in flatten([

    # This will iterate over the service_accounts map and return a list of maps
    # based of the github_repositories that includes the name key.

    for service_account_key, name in local.service_accounts : [
      for repository in name.github_repositories : {
        name       = service_account_key
        repository = repository
        ref        = lookup(local.service_accounts[service_account_key], "github_ref", null)
      }
    ]
  ]) : service_account.repository => service_account }
}
