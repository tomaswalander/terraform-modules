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
| [azurerm_api_management_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_tracing"></a> [allow\_tracing](#input\_allow\_tracing) | Determines whether tracing can be enabled. Must not be allowed for any third party subscriptions. | `bool` | `false` | no |
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | The name of the APIM instance. | `string` | n/a | yes |
| <a name="input_apim_product_id"></a> [apim\_product\_id](#input\_apim\_product\_id) | The id of the Apim Product to connect to the subscription | `string` | n/a | yes |
| <a name="input_apim_resource_group_name"></a> [apim\_resource\_group\_name](#input\_apim\_resource\_group\_name) | The name of the resource group where the APIM instance is. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the Apim Subscription. | `string` | n/a | yes |
| <a name="input_main_subscription_primary_key"></a> [main\_subscription\_primary\_key](#input\_main\_subscription\_primary\_key) | The primary subscription key of this product | `string` | n/a | yes |
| <a name="input_main_subscription_secondary_key"></a> [main\_subscription\_secondary\_key](#input\_main\_subscription\_secondary\_key) | The secondary subscription key of this product | `string` | n/a | yes |
| <a name="input_state"></a> [state](#input\_state) | The state of the APIM product's subscription. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_subscription_id"></a> [apim\_subscription\_id](#output\_apim\_subscription\_id) | The ID of the created APIM Subscription. |
<!-- END_TF_DOCS -->