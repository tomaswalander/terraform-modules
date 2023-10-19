terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0"
    }
  }
}

# High-level simplified view:
# App -> Subnet <=> NAT <=> Public Ip
# I.e., App traffic goes to subnet which has a NAT which in turn has a static public IP

data "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  resource_group_name = var.public_ip_resource_group_name
}

# Force app outgoing traffic to the subnet
resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  app_service_id = var.app_resource_id
  subnet_id      = var.subnet_id
}

# Create a NAT gateway
resource "azurerm_nat_gateway" "this" {
  name                = var.gateway_name  
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Associate the NAT with the public IP
resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = data.azurerm_public_ip.this.id
}

# Connect the NAT to the subnet
resource "azurerm_subnet_nat_gateway_association" "this" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.this.id
}