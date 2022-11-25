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

output "service_account_emails" {
  description = "The service account emails"
  value = {
    for k, s in google_service_account.this : k => s.email
  }
}

output "storage_buckets" {
  description = "The terraform state bucket names"
  value = {
    for k, s in module.storage_bucket : k => s.name
  }
}
