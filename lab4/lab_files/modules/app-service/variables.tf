variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "location" {
  type        = string
  description = "Region of the Infrastructure"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"

}

variable "sku_name" {
  type        = string
  description = "SKU Name"

}

variable "web_app_name" {
  type        = string
  description = "Name of the Web App"

}