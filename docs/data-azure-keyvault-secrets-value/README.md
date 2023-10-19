[DATA] Azure Key Vault Secrets
==============================

[[_TOC_]]

## Before you use this module

> <span style="background-color: #ff6e67; border-radius: 3px; color: black; padding:2px;">**CAUTION:**</span> This module could leak your secrets in plain text to unexpected audiences.

Due to the nature of Terraform and its state files secrets handled by Terraform may not be dealt with in a completely secure way. In fact, it is quite likely that a secret fetched from an Azure Key Vault ends up in the terraform state file. While state files can be kept rather securely in an Azure Storage account they are not encrypted and therefore, not as secure as the Azure Key Vault itself.

> <span style="background-color: #739af5; border-radius: 3px; color: black; padding:2px;">**NOTE:**</span> If you do not need the secret value - please, refer to the `data-keyvault-secrets-metadata` module which only exposes enough information about the secret to fetch it in more secure ways.

However, there are situations where the only work around to using this module would be manually managing the secrets - which I deem to be worse.


----------------------------------
<br />

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The name of the key vault containing the secrets. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the key vault is located. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The name of the secrets. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The Azure resource Id of the key vault where the secrets are located |
| <a name="output_secrets_data"></a> [secrets\_data](#output\_secrets\_data) | Meta data about the requested secrets. Note: The value is not exposed. |
<!-- END_TF_DOCS -->