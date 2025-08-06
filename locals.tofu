# Local Values
# https://opentofu.org/docs/language/values/locals

locals {
  service_accounts = {
    "plt-backstage" = {
      github_repositories = ["backstage"]
    }

    "plt-dd-organization" = {
      github_repositories = ["datadog-organization-management"]
    }

    "plt-istio-test" = {
      github_repositories = ["istio-test"]
    }

    "plt-gh-organization" = {
      github_repositories = ["github-organization-management"]
    }

    "plt-k8s" = {
      github_repositories = ["google-cloud-kubernetes"]
    }

    "plt-lz-audit" = {
      github_repositories = ["google-cloud-audit-logging"]
    }

    "plt-lz-backend" = {
      github_repositories        = ["google-cloud-opentofu-backend"]
      billing_user_group_manager = true
    }

    "plt-lz-hierarchy" = {

      # The service account used to create the folder hierarchy will need to be added
      # to the Groups Admins role in the Google Workspace Admin Console.

      github_repositories = ["google-cloud-hierarchy"]
    }

    "plt-lz-identity" = {
      github_repositories = ["google-cloud-workload-identity"]
    }

    "plt-lz-networking" = {
      github_repositories = ["google-cloud-networking"]
    }

    "plt-lz-services" = {
      github_repositories = ["google-cloud-services"]
    }

    "plt-lz-testing" = {
      github_repositories = [
        "github-opentofu-gcp-called-workflows"
      ]
    }
  }

  # Flatten Function
  # https://opentofu.org/docs/language/functions/flatten

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
