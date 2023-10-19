Azure hosted Redis
==================

> The module creates an Azure Redis instance

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.75.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.75.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.primary_connection_string_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.secondary_connection_string_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_redis_cache.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | The configuration of the Redis Cache using settings for sku\_name and capacity. For "Basic" and "Standard" capacity must be between 0 and 6 inclusive, and for "Premium" it must be between 1 and 4 inclusive. Currently this module does not allow for "Premium". | <pre>object({<br>    sku_name = string<br>    capacity = number<br>  })</pre> | <pre>{<br>  "capacity": 0,<br>  "sku_name": "Basic"<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment. | `string` | n/a | yes |
| <a name="input_key_vault_for_access_keys"></a> [key\_vault\_for\_access\_keys](#input\_key\_vault\_for\_access\_keys) | An existing Azure Key Vault where to store the Access Keys of the Redis instance. | <pre>object({<br>    key_vault_name      = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource group where to keep the resource | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Sql Server | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where to keep the resource | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to use for created resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the created Azure Redis resource |
| <a name="output_redis_primary_connection_string"></a> [redis\_primary\_connection\_string](#output\_redis\_primary\_connection\_string) | Information to retrieve the primary connection string of the Azure Redis instance from the provided key vault. |
| <a name="output_redis_secondary_connection_string"></a> [redis\_secondary\_connection\_string](#output\_redis\_secondary\_connection\_string) | Information to retrieve the secondary connection string of the Azure Redis instance from the provided key vault. |
<!-- END_TF_DOCS -->

## Needed permissions

> *NOTE:* A service principal, msi or user account using this module need to have the following permissions.

- Microsoft.Cache/redis/write
- Microsoft.Cache/redis/read
- Microsoft.Cache/redis/delete
- Microsoft.Cache/redis/listKeys/action
