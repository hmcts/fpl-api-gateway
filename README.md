# terraform-module-template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.69.0 |
| <a name="provider_azurerm.aks-cftapps"></a> [azurerm.aks-cftapps](#provider\_azurerm.aks-cftapps) | 3.69.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fpl-cafcass-api-mgmt-api"></a> [fpl-cafcass-api-mgmt-api](#module\_fpl-cafcass-api-mgmt-api) | git@github.com:hmcts/cnp-module-api-mgmt-api | master |
| <a name="module_fpl-cafcass-api-mgmt-product"></a> [fpl-cafcass-api-mgmt-product](#module\_fpl-cafcass-api-mgmt-product) | git@github.com:hmcts/cnp-module-api-mgmt-product | master |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_subscription.fpl_cafcass_api_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/resources/api_management_subscription) | resource |
| [azurerm_key_vault_secret.fpl_cafcass_api_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault.fis_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.s2s_client_id](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.s2s_client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/data-sources/key_vault_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_subscription_id"></a> [aks\_subscription\_id](#input\_aks\_subscription\_id) | n/a | `any` | n/a | yes |
| <a name="input_apim_suffix"></a> [apim\_suffix](#input\_apim\_suffix) | n/a | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_fpl_cafcass_api_product_name"></a> [fpl\_cafcass\_api\_product\_name](#input\_fpl\_cafcass\_api\_product\_name) | n/a | `string` | `"fpl-cafcass"` | no |
<!-- END_TF_DOCS -->