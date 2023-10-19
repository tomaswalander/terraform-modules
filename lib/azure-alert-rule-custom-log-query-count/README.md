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
| [azurerm_monitor_scheduled_query_rules_alert.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | A list of Action Group Ids where to send alerts from this rule. | `list(string)` | n/a | yes |
| <a name="input_application_insights"></a> [application\_insights](#input\_application\_insights) | Information about the Azure Application Insights instance where to create the alert rule. | <pre>object({<br>    id                  = string<br>    location            = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A more descriptive text what the alert rule actually means. What you type here will greatly aid the Engineer On Call quickly graps what's going on. | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether or not the alert rule is enabled. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | The frequency for how often the rule should be evaluated in minutes. | `number` | `5` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Alert Rule. | `string` | n/a | yes |
| <a name="input_operator"></a> [operator](#input\_operator) | The operator to use for threshold comparison. | `string` | n/a | yes |
| <a name="input_properties"></a> [properties](#input\_properties) | Additional properties to include in the Alert to help identify what's going on. | `map(string)` | n/a | yes |
| <a name="input_query"></a> [query](#input\_query) | The query to use for monitoring. See examples here: https://registry.terraform.io/providers/hashicorp/azurerm/2.89.0/docs/resources/monitor_scheduled_query_rules_alert | `string` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity level to use for fired alerts. | `number` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The threshold for when the rule should fire an alert. | `number` | `5` | no |
| <a name="input_time_window"></a> [time\_window](#input\_time\_window) | The time window during with the rule threshold will be checked. Must be greater than or equal to the frequency. | `number` | `10` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->