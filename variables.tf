variable "storage_account_name" {
  description = "Globally unique name for the Storage Account (3-24 chars, lowercase alphanumeric only)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "resource_group_name" {
  description = "Name of the Resource Group containing the Storage Account."
  type        = string
}

variable "location" {
  description = "Azure region for the Storage Account."
  type        = string
}

variable "container_name" {
  description = "Name of the private Blob container to create inside the Storage Account."
  type        = string
  default     = "container1"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.container_name))
    error_message = "Container name must be 3-63 characters, lowercase letters, numbers, and hyphens only."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access to the Storage Account is enabled. Set to false after Private Endpoint is verified."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to apply to the Storage Account."
  type        = map(string)
  default     = {}
}
