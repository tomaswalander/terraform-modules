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
| [azurerm_api_management_api.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | The name of the Apim instance. | `string` | n/a | yes |
| <a name="input_apim_resource_group_name"></a> [apim\_resource\_group\_name](#input\_apim\_resource\_group\_name) | The name of the resource group where the Apim instance is. | `string` | n/a | yes |
| <a name="input_base_path"></a> [base\_path](#input\_base\_path) | The base path of the Api. | `string` | n/a | yes |
| <a name="input_content"></a> [content](#input\_content) | The content of this api | <pre>object({<br>    kind     = string<br>    location = optional(string)<br>    value    = optional(string)<br>  })</pre> | <pre>{<br>  "kind": "none",<br>  "location": "",<br>  "value": ""<br>}</pre> | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the Api. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Apim Api to create. | `string` | n/a | yes |
| <a name="input_revision"></a> [revision](#input\_revision) | The revision of the Api. | `string` | n/a | yes |
| <a name="input_revision_description"></a> [revision\_description](#input\_revision\_description) | A description of the revision of this Api. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The name of the created api |
<!-- END_TF_DOCS -->