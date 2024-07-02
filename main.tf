locals {
  api_mgmt_suffix  = var.apim_suffix == "" ? var.env : var.apim_suffix
  api_mgmt_name    = "cft-api-mgmt-${local.api_mgmt_suffix}"
  api_mgmt_rg      = join("-", ["cft", var.env, "network-rg"])
  fpl_key_vault    = join("-", ["fpl", var.env])
  fpl_key_vault_rg = join("-", ["fpl-case-service", var.env])

  fpl_api_url = join("", ["http://fpl-case-service-", var.env, ".service.core-compute-", var.env, ".internal"])
  s2sUrl      = join("", ["http://rpe-service-auth-provider-", var.env, ".service.core-compute-", var.env, ".internal"])

}

provider "azurerm" {
  alias           = "aks-cftapps"
  subscription_id = var.aks_subscription_id
  features {}
}

data "azurerm_key_vault" "fpl_key_vault" {
  name                = local.fpl_key_vault
  resource_group_name = local.fpl_key_vault_rg
}


#data "azurerm_key_vault_secret" "s2s_client_id" {
#  name         = "gateway-s2s-client-id"
#  key_vault_id = data.azurerm_key_vault.fpl_key_vault.id
#}

data "azurerm_key_vault_secret" "s2s_client_secret" {
#  name         = "gateway-s2s-client-secret"
  name         = "fpl-case-service-s2s-secret"
  key_vault_id = data.azurerm_key_vault.fpl_key_vault.id
}
