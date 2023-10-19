Api Management API with product assignment from OpenApi-specification
=====================================================================

> The module creates an Api Management API according to the provided OpenApi specification including **ONLY** the specified `operationIds` and grants access to all provided `products`.

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
| [azurerm_api_management_product_api.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | The name of the Apim instance. | `string` | n/a | yes |
| <a name="input_apim_resource_group_name"></a> [apim\_resource\_group\_name](#input\_apim\_resource\_group\_name) | The name of the resource group where the Apim instance is. | `string` | n/a | yes |
| <a name="input_base_path"></a> [base\_path](#input\_base\_path) | The base path of the Api. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the Api. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Apim Api to create. | `string` | n/a | yes |
| <a name="input_open_api_operation_ids"></a> [open\_api\_operation\_ids](#input\_open\_api\_operation\_ids) | A list of operationIds from the OpenApi specification to include in this API. Non-existing opeartionIds will be silently ignored. | `list(string)` | n/a | yes |
| <a name="input_open_api_spec_in_json"></a> [open\_api\_spec\_in\_json](#input\_open\_api\_spec\_in\_json) | A json-encoded string containing an Open Api specification to use for creating the Api. | `string` | n/a | yes |
| <a name="input_products"></a> [products](#input\_products) | A list of product ids to grant access to this Api. | `list(string)` | n/a | yes |
| <a name="input_revision"></a> [revision](#input\_revision) | The revision of the Api. | `string` | n/a | yes |
| <a name="input_revision_description"></a> [revision\_description](#input\_revision\_description) | A description of the revision of this Api. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_test"></a> [test](#output\_test) | n/a |
<!-- END_TF_DOCS -->

## Example

```haskell

data "http" "example" {
  url = "https://my-azure-app.azurewebsites.net/api/swagger.json"

  request_headers = {
    Accept = "application/json"
  }

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Failed fetching Open Api Specification for Api."
    }
  }
}


module "example" {
  source   = "./path/to/modules/lib/azure-apim-api-from-openapi-with-product-assignment"

  name         = "api-name"
  display_name = "Api Display Name"
  
  base_path = "base"

  revision             = "1"
  revision_description = "This is the first revision"

  apim_resource_group_name = "rg-example"
  apim_name                = "apim-example"
  
  open_api_spec_in_json  = data.http.example.response_body
  open_api_operation_ids = ["operation-1", "operation-2"]

  products = [
    "product-id-1" ## or sourced from module apim-product-with-subscription
  ]
}

```