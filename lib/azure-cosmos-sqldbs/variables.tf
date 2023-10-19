variable "cosmosdb_account_name" {
  type        = string
  description = "The name to use for the CosmosDB Account"

  validation {
    condition     = substr(var.cosmosdb_account_name, 0, 7) == "cosmos-" && length(var.cosmosdb_account_name) <= 44
    error_message = "The name must start with 'cosmos-' and have a maximum of 44 characters."
  }
}

variable "location" {
  type        = string
  description = "The Azure location where to create the resources" 
}

variable "resource_group_name" {
  type        = string
  description = "The Azure resource group containing the resources" 
}

variable "consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  })
  description = "Configures the database consistency"
  default = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }
}

variable "capabilities" {
  type = list(string)
  description = "A list of capabilities to enable on the CosmosDB Account."
  default = ["EnableAggregationPipeline"]
  
  validation {
    condition = alltrue([
      for c in var.capabilities : contains(["EnableAggregationPipeline"], c)
    ])
    error_message = "Supported capabilities are [\"EnableAggregationPipeline\"]."
  }
}

variable "failover_geo_locations" {
  type = list(object({
    location = string
  }))
  description = "A list of geo_locations for failover, used to define where data should be replicated. The primary geo_location will be the one specified as \"location\". Any locations given in this setting will be used as failover locations in increasing priority order according to array index."
  default = []
}
 
#############
# Databases #
#############

variable "sql_databases" {
  type   = map(object({
    db_max_throughput = optional(number)
  }))
  description = "A map of databases to create with optional config."

  validation {
    condition    = alltrue([
      for k,v in var.sql_databases : substr(k, 0, 13) == "cosmos-sqldb-"
    ])
    error_message = "All sqldb names must start with 'cosmos-sqldb-'."
  }
}

###########
# Tagging #
###########
variable "environment" {
  type        = string
  description = "The environment"
}

variable "owner" {
  type        = string
  description = "The owner"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to use for created resources."
}