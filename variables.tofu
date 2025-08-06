# Input Variables
# https://opentofu.org/docs/language/values/variables

# This is only needed during bootstrapping.

# variable "billing_project" {
#   description = "The quota project to send in `user_project_override`, used for all requests sent from the provider. If set on a resource that supports sending the resource project, this value will supersede the resource project. This field is ignored if `user_project_override` is set to false or unset"
#   type        = string
# }

variable "billing_users_group_id" {
  description = "The numeric ID of the billing users group"
  type        = string
  default     = "03dy6vkm4a7ag9g"
}

variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog APP key"
  type        = string
  sensitive   = true
}

variable "datadog_enable" {
  description = "Enable Datadog integration"
  type        = bool
  default     = false
}

variable "project_billing_account" {
  description = "The alphanumeric ID of the billing account this project belongs to"
  type        = string
  default     = "01C550-A2C86B-B8F16B"
}

variable "project_cis_2_2_logging_sink_project_id" {
  description = "The CIS 2.2 logging sink benchmark project ID"
  type        = string
}

variable "project_folder_id" {
  description = "The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified"
  type        = string
}

variable "project_monthly_budget_amount" {
  description = "The monthly budget amount in USD to set for the project"
  type        = number
  default     = 5
}

variable "workload_identity_pool_name" {
  description = "The workload identity pool name"
  type        = string
}
