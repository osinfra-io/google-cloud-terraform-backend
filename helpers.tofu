# OpenTofu Core Helpers Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-core-helpers

module "helpers" {
  source = "github.com/osinfra-io/opentofu-core-helpers//root?ref=v0.1.3"

  cost_center         = "x001"
  data_classification = "public"
  repository          = "google-cloud-opentofu-backend"
  team                = "platform-google-cloud-landing-zone"
}
