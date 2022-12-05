# Output Values
# https://www.terraform.io/language/values/outputs

output "project_number" {
  description = "The project number"
  value       = module.project.project_number
}

output "project_id" {
  description = "The project ID"
  value       = module.project.project_id
}

output "github_actions_service_account_emails" {
  description = "The GitHub Actions service account emails"
  value = {
    for k, s in google_service_account.github_actions : k => s.email
  }
}

output "terraform_state_storage_buckets" {
  description = "The terraform state bucket names"
  value = {
    for k, s in module.terraform_state_storage_bucket : k => s.name
  }
}
