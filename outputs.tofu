# Output Values
# https://opentofu.org/docs//language/values/outputs

output "project_number" {
  description = "The project number"
  value       = module.project.number
}

output "project_id" {
  description = "The project ID"
  value       = module.project.id
}

output "github_actions_service_account_emails" {
  description = "The GitHub Actions service account emails"
  value = {
    for k, v in google_service_account.github_actions : k => v.email
  }
}

output "opentofu_state_storage_buckets" {
  description = "The OpenTofu state bucket names"
  value = {
    for k, v in module.opentofu_state_storage_bucket : k => v.name
  }
}
