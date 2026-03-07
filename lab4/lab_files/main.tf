# Resource group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location

}


# Web App module call 
module "app_service" {

  source = "./modules/app-service"

  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = azurerm_resource_group.resource_group.location
  app_service_plan_name = var.app_service_plan_name
  web_app_name          = var.web_app_name
  sku_name              = var.sku_name

}