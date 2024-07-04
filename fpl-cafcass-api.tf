module "fpl-cafcass-api-mgmt-product" {
  source = "git@github.com:hmcts/cnp-module-api-mgmt-product?ref=master"

  api_mgmt_name                 = local.api_mgmt_name
  api_mgmt_rg                   = local.api_mgmt_rg
  name                          = var.fpl_cafcass_api_product_name
  product_access_control_groups = ["developers"]
  approval_required             = "false"
  subscription_required         = "true"
  providers = {
    azurerm = azurerm.aks-cftapps
  }
}

module "fpl-cafcass-api-mgmt-api" {
  source = "git@github.com:hmcts/cnp-module-api-mgmt-api?ref=master"

  api_mgmt_name = local.api_mgmt_name
  api_mgmt_rg   = local.api_mgmt_rg
  revision      = "1"
  service_url   = local.fpl_api_url
  product_id    = module.fpl-cafcass-api-mgmt-product.product_id
  name          = join("-", [var.fpl_cafcass_api_product_name, "api"])
  display_name  = "FPL Cafcass API"
  path          = "public-law-api"
  protocols     = ["http", "https"]
  swagger_url   = "https://raw.githubusercontent.com/hmcts/cnp-api-docs/master/docs/specs/fpl-cafcass-api.json"
  #  subscription_required = "false"
  content_format = "openapi-link"

  providers = {
    azurerm = azurerm.aks-cftapps
  }
}

data "template_file" "api_mgmt_policy_template" {
  template = file("${path.module}/template/api-policy.xml")

  vars = {
    #    s2s_client_id     = data.azurerm_key_vault_secret.s2s_client_id.value
    s2s_client_id     = "family-public-law"
    s2s_client_secret = data.azurerm_key_vault_secret.s2s_client_secret.value
    s2s_base_url      = local.s2sUrl
  }
}

module "fpl-cafcass-api-policy" {
  source = "git@github.com:hmcts/cnp-module-api-mgmt-api-policy?ref=master"

  api_mgmt_name = local.api_mgmt_name
  api_mgmt_rg   = local.api_mgmt_rg

  api_name               = module.fpl-cafcass-api-mgmt-api.name
  api_policy_xml_content = data.template_file.api_mgmt_policy_template.rendered

  providers = {
    azurerm = azurerm.aks-cftapps
  }
}

resource "azurerm_api_management_subscription" "fpl_cafcass_api_subscription" {
  api_management_name = local.api_mgmt_name
  resource_group_name = local.api_mgmt_rg
  product_id          = module.fpl-cafcass-api-mgmt-product.id
  display_name        = "FPL Cafcass API Subscription"
  state               = "active"
  provider            = azurerm.aks-cftapps

}

resource "azurerm_key_vault_secret" "fpl_cafcass_api_subscription_key" {
  name         = "fpl-cafcass-api-subscription-key"
  value        = azurerm_api_management_subscription.fpl_cafcass_api_subscription.primary_key
  key_vault_id = data.azurerm_key_vault.fpl_key_vault.id
}