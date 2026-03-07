variable "resource_group_name" {
  type        = string
  description = "Name of the RG"
  default     = "rg_web_app"
}

variable "location" {
  type        = string
  description = "Region of the web app"
  default     = "westeurope"

}

variable "sku_name" {
  type        = string
  description = "SKU Name"
  default     = "B1"

}

variable "app_service_plan_name" {
  type        = string
  description = "App service plan name"
  default     = "rameh-asp"

}

variable "web_app_name" {
  type        = string
  description = "Web App Name"
  default     = "rameh-linuxwebapp-dev"

}

