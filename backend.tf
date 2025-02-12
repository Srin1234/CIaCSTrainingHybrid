provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hybrid" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_mysql_flexible_server" "hybrid" {
  name                = var.mysql_server_name
  location            = azurerm_resource_group.hybrid.location
  resource_group_name = azurerm_resource_group.hybrid.name

  administrator_login    = var.mysql_server_login
  administrator_password = var.mysql_server_password

  sku_name   = "B_Standard_B1s"
  version    = "5.7"
}

resource "azurerm_mysql_flexible_database" "hybrid" {
  name                = "shop_inventory"
  resource_group_name = azurerm_resource_group.hybrid.name
  server_name         = azurerm_mysql_flexible_server.hybrid.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "hybrid" {
  name                = "hybrid"
  resource_group_name = azurerm_resource_group.hybrid.name
  server_name         = azurerm_mysql_flexible_server.hybrid.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mysql_flexible_server_configuration" "parameters" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.hybrid.name
  server_name         = azurerm_mysql_flexible_server.hybrid.name
  value               = "OFF"
}
