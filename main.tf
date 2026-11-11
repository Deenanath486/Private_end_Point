# ---------------------------------------------------------------------------
# Azure Storage Account
# ---------------------------------------------------------------------------
resource "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # Security hardening
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false # disable anonymous blob access

  # Public network access is configurable so the lab can start with it
  # enabled for initial upload/verification, then locked down after PE is
  # confirmed working. Set storage_public_network_access_enabled = false
  # in terraform.tfvars once Private Endpoint is verified.
  public_network_access_enabled = var.public_network_access_enabled

  # Shared key access — keep enabled so az storage CLI commands work
  # during the lab. Disable after switching to Azure AD auth in production.
  shared_access_key_enabled = true

  blob_properties {
    # Soft delete for blobs — 7-day retention for lab safety
    delete_retention_policy {
      days = 7
    }

    # Versioning off for lab simplicity
    versioning_enabled = false
  }

  tags = var.tags
}

# ---------------------------------------------------------------------------
# Blob Container
# ---------------------------------------------------------------------------
resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private" # no anonymous access
}
