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
| [azurerm_api_management_product_api.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_api_name"></a> [apim\_api\_name](#input\_apim\_api\_name) | The name of Apim API. | `string` | n/a | yes |
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | The name of the Apim instance. | `string` | n/a | yes |
| <a name="input_apim_product_id"></a> [apim\_product\_id](#input\_apim\_product\_id) | The ID of the Apim Product. | `string` | n/a | yes |
| <a name="input_apim_resource_group_name"></a> [apim\_resource\_group\_name](#input\_apim\_resource\_group\_name) | The name of the resource group where the Apim instance is. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->