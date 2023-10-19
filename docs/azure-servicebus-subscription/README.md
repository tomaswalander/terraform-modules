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
| [azurerm_servicebus_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) | resource |
| [azurerm_servicebus_subscription_rule.correlation_filter_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_correlation_filters"></a> [correlation\_filters](#input\_correlation\_filters) | A map of correlation filters to create rules for which messages will be forwarded from the topic to the subscription. If left undefined or empty all messages will be forwarded. Defaults to {}. | <pre>map(object({<br>    content_type        = optional(string)<br>    correlation_id      = optional(string)<br>    label               = optional(string)<br>    message_id          = optional(string)<br>    reply_to            = optional(string)<br>    reply_to_session_id = optional(string)<br>    session_id          = optional(string)<br>    to                  = optional(string)<br>    properties          = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_dead_lettering_on_filter_evaluation_error"></a> [dead\_lettering\_on\_filter\_evaluation\_error](#input\_dead\_lettering\_on\_filter\_evaluation\_error) | Whether or not to send the event to deadletter on filter evaluation error. Defaults to true. | `bool` | `true` | no |
| <a name="input_max_delivery_count"></a> [max\_delivery\_count](#input\_max\_delivery\_count) | The maximum number of times an event will be retried. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the subscription to create. Must be unique within one Azure Servicebus topic. | `string` | n/a | yes |
| <a name="input_topic_id"></a> [topic\_id](#input\_topic\_id) | The Id of the Azure Servicebus Topic to subscribe to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the created Azure Servicebus Topic Subscription. |
<!-- END_TF_DOCS -->