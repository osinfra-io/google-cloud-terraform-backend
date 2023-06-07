# Local Values
# https://www.terraform.io/language/values/locals

locals {

  # Please keep this map in alphabetical order.

  service_accounts = {
    "plt-gh-organization" = {
      github_repositories = ["github-organization-management"]
    }

    "plt-lz-audit" = {
      github_repositories = ["google-cloud-audit-logging"]
    }

    "plt-lz-backend" = {
      github_repositories = ["google-cloud-terraform-backend"]
    }

    "plt-lz-hierarchy" = {

      # The service account used to create the folder hierarchy will need to be added
      # to the Groups Admins role in the Google Workspace Admin Console.

      github_repositories = ["google-cloud-hierarchy"]
    }

    "plt-lz-identity" = {
      github_repositories = ["google-cloud-workload-identity"]
    }

    "plt-lz-services" = {
      github_repositories = ["google-cloud-services"]
    }

    "plt-lz-testing" = {
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
      }
    ]
  ]) : service_account.repository => service_account }
}
