PagerDuty service with Azure and Slack integration
==================================================

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_pagerduty"></a> [pagerduty](#requirement\_pagerduty) | >=2.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | >=2.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pagerduty_service.this](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_service_dependency.this](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_dependency) | resource |
| [pagerduty_service_integration.azure_webhook](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/service_integration) | resource |
| [pagerduty_slack_connection.slack](https://registry.terraform.io/providers/pagerduty/pagerduty/latest/docs/resources/slack_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_business_service_id"></a> [business\_service\_id](#input\_business\_service\_id) | The ID of the PagerDuty business service this service belongs to if applicable. | `string` | `""` | no |
| <a name="input_escalation_policy_id"></a> [escalation\_policy\_id](#input\_escalation\_policy\_id) | The ID of the PagerDuty escalation policy to use. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the PagerDuty service to create. | `string` | n/a | yes |
| <a name="input_slack_channel_id"></a> [slack\_channel\_id](#input\_slack\_channel\_id) | The ID of a slack channel where to connect the service alerts | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_integration_webhook"></a> [service\_integration\_webhook](#output\_service\_integration\_webhook) | The webhook to use for sending events to this PagerDuty service |
<!-- END_TF_DOCS -->