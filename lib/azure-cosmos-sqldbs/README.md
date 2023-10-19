Azure CosmosDB Account with SQL flavour
=======================================

> The module creates Azure CosmosDB Account with SQL flavour and containing the provided Cosmos SQL Databases.

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
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | A list of capabilities to enable on the CosmosDB Account. | `list(string)` | <pre>[<br>  "EnableAggregationPipeline"<br>]</pre> | no |
| <a name="input_consistency_policy"></a> [consistency\_policy](#input\_consistency\_policy) | Configures the database consistency | <pre>object({<br>    consistency_level       = string<br>    max_interval_in_seconds = number<br>    max_staleness_prefix    = number<br>  })</pre> | <pre>{<br>  "consistency_level": "BoundedStaleness",<br>  "max_interval_in_seconds": 10,<br>  "max_staleness_prefix": 200<br>}</pre> | no |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | The name to use for the CosmosDB Account | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment | `string` | n/a | yes |
| <a name="input_failover_geo_locations"></a> [failover\_geo\_locations](#input\_failover\_geo\_locations) | A list of geo\_locations for failover, used to define where data should be replicated. The primary geo\_location will be the one specified as "location". Any locations given in this setting will be used as failover locations in increasing priority order according to array index. | <pre>list(object({<br>    location = string<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where to create the resources | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Azure resource group containing the resources | `string` | n/a | yes |
| <a name="input_sql_databases"></a> [sql\_databases](#input\_sql\_databases) | A map of databases to create with optional config. | <pre>map(object({<br>    db_max_throughput = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to use for created resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmos_db_account_endpoint"></a> [cosmos\_db\_account\_endpoint](#output\_cosmos\_db\_account\_endpoint) | The endpoint of the created Azure CosmosDB Account. |
| <a name="output_cosmos_db_account_id"></a> [cosmos\_db\_account\_id](#output\_cosmos\_db\_account\_id) | The ID of the created Azure CosmosDB Account. |
<!-- END_TF_DOCS -->

## Needed permissions

> *NOTE:* A service principal, msi or user account using this module need to have the following permissions.

- Microsoft.DocumentDB/databaseAccounts/read
- Microsoft.DocumentDB/databaseAccounts/write
- Microsoft.DocumentDB/databaseAccounts/delete
- Microsoft.DocumentDB/databaseAccounts/sqlDatabases/read
- Microsoft.DocumentDB/databaseAccounts/sqlDatabases/write
- Microsoft.DocumentDB/databaseAccounts/sqlDatabases/delete
- Microsoft.DocumentDB/databaseAccounts/listKeys/action
- Microsoft.DocumentDB/databaseAccounts/readonlykeys/action
- Microsoft.DocumentDB/databaseAccounts/listConnectionStrings/action