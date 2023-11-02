terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.27.0"
    }
  }
}

data "azurerm_private_dns_zone" "dns_zone" {
  name                 = "privatelink.azurewebsites.net"
  resource_group_name  = var.private_dns_zone_resource_group_name
}

locals {
  prefix_less_name = trimprefix(var.name, "pe-")
  
}

resource "azurerm_private_endpoint" "this" {
  name                = var.name
  
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id           = var.subnet_id
  
  tags = merge(
    var.tags, {
      environment = var.environment
      owner       = var.owner
    }
  )
  
  private_dns_zone_group {
    name              = "privatelink.azurewebsites.net"
    private_dns_zone_ids = [
      data.azurerm_private_dns_zone.dns_zone.id
    ]
  } 

  private_service_connection {
    name                           = "psc-${local.prefix_less_name}"
    private_connection_resource_id = var.app_resource_id

    is_manual_connection = false
    subresource_names    = [ "sites" ]
  }
}