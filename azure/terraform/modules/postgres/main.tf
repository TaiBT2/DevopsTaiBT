resource "azurerm_postgresql_server" "this" {
  name                = "${var.project}-psqlserver"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  storage_mb = var.storage_mb
  backup_retention_days = 7
  geo_redundant_backup_enabled = true

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  version = var.version

  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "this" {
  name                = "${var.project}-db"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}