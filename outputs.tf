output "storage_account_id" {
  description = "Resource ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name of the Storage Account."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob service endpoint URL (used for connectivity testing)."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_name" {
  description = "Name of the Blob container."
  value       = azurerm_storage_container.this.name
}

# Storage Account keys are deliberately NOT exported as outputs to avoid
# exposing credentials in Terraform state outputs or CI logs.
# Access keys can be retrieved via:
#   az storage account keys list --account-name <name> --resource-group <rg>
