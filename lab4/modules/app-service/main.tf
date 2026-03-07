
# Linux App Service Plan
resource "azurerm_service_plan" "linux_app_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name

}

# Linux Web App
resource "azurerm_linux_web_app" "web_app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.linux_app_plan.id

  site_config {}
}

