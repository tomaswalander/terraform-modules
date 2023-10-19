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
| [azurerm_monitor_metric_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | A list of Action Group Ids where to send alerts from this rule. | `list(string)` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A more descriptive text what the alert rule actually means. What you type here will greatly aid the Engineer On Call quickly graps what's going on. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | The frequency for how often the rule should be evaluated in minutes. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Alert Rule. | `string` | n/a | yes |
| <a name="input_properties"></a> [properties](#input\_properties) | Additional properties to include in the Alert to help identify what's going on. | `map(string)` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity level to use for fired alerts. | `number` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The threshold for when the rule should fire an alert. | `number` | n/a | yes |
| <a name="input_time_window"></a> [time\_window](#input\_time\_window) | The time window during with the rule threshold will be checked. Must be greater than or equal to the frequency. | `number` | `5` | no |
| <a name="input_webtest"></a> [webtest](#input\_webtest) | Information about the WebTest to monitor and its parent Azure Application Insights instance. | <pre>object({<br>    name                                     = string<br>    application_insights_id                  = string<br>    application_insights_resource_group_name = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->