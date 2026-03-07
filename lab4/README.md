# Lab 4 — Implementing Terraform Modules with Azure App Service

## Objective

In this lab you will learn how to **create and use Terraform modules** to organize infrastructure code and improve reusability.

By the end of this lab, you will be able to:

* Create a **custom Terraform module**
* Separate reusable infrastructure components from the main configuration
* Deploy an **Azure App Service Plan**
* Deploy a **Linux Web App** using the module
* Pass variables between the root configuration and a module

Using modules is a key best practice when building **scalable Infrastructure as Code projects**.

---

# Scenario

Your team wants to standardize how **web applications are deployed** in Azure.

To achieve this, you will create a **Terraform module** responsible for deploying:

* An **App Service Plan**
* A **Linux Web App**

The root Terraform configuration will then **consume this module**.

This approach allows teams to **reuse the same infrastructure definition** across multiple projects.

---

# Lab Architecture

```text
Terraform Root Configuration
│
└── Module: app-service
        │
        ├── App Service Plan
        └── Linux Web App
```

The **root module** will provide the configuration parameters, while the **child module** will implement the infrastructure resources.

---

# Step 1 — Create the Project Structure

Create the following folder structure:

```text
terraform-module-lab
│
├── main.tf
├── variables.tf
├── providers.tf
├── outputs.tf
│
└── modules
    │
    └── app-service
        │
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

This structure separates:

* **Root configuration** → environment-specific
* **Modules** → reusable infrastructure logic

---

# Step 2 — Configure the Azure Provider

Create the provider configuration.

Example:

```hcl
provider "azurerm" {
  features {}
}
```

Run:

```bash
terraform init
```

---

# Step 3 — Create the App Service Module

Navigate to the module folder:

```text
modules/app-service
```

Inside this module you will implement:

* `azurerm_service_plan`
* `azurerm_linux_web_app`

The module should accept variables such as:

| Variable                | Description                                     |
| ----------------------- | ----------------------------------------------- |
| `resource_group_name`   | Resource group where resources will be deployed |
| `location`              | Azure region                                    |
| `app_service_plan_name` | Name of the App Service Plan                    |
| `web_app_name`          | Name of the Linux Web App                       |
| `sku_name`              | App Service Plan SKU                            |

---

# Step 4 — Implement the App Service Plan

Create the resource block for the **App Service Plan**.

Required parameters include:

| Parameter | Value |
| --------- | ----- |
| OS Type   | Linux |
| SKU       | B1    |
| Tier      | Basic |

Example structure:

```hcl
resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}
```

---

# Step 5 — Implement the Linux Web App

Create a **Linux Web App** associated with the service plan.

Example structure:

```hcl
resource "azurerm_linux_web_app" "web_app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {}
}
```

---

# Step 6 — Define Module Variables

Inside `modules/app-service/variables.tf`, declare all required variables.

Example variables:

| Variable                | Type   | Description           |
| ----------------------- | ------ | --------------------- |
| `resource_group_name`   | string | Resource group name   |
| `location`              | string | Azure region          |
| `app_service_plan_name` | string | App Service Plan name |
| `web_app_name`          | string | Web App name          |
| `sku_name`              | string | App Service Plan SKU  |

Follow the **best practices** learned in previous labs:

* Include **type**
* Include **description**
* Avoid hardcoded values inside modules

---

# Step 7 — Call the Module from the Root Configuration

Now use the module in the **root `main.tf` file**.

Example structure:

```hcl
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location

}

module "app_service" {

  source = "./modules/app-service"

  resource_group_name    = var.resource_group_name
  location               = var.location
  app_service_plan_name  = var.app_service_plan_name
  web_app_name           = var.web_app_name
  sku_name               = var.sku_name

}
```

This instructs Terraform to **use the module and pass variables to it**.

---

# Step 8 — Define Root Variables

Create variables in the root `variables.tf` file.

Example parameters:

| Variable                | Example Value                |
| ----------------------- | ---------------------------- |
| `resource_group_name`   | rg-terraform-labs            |
| `location`              | one of the supported regions |
| `app_service_plan_name` | tf-lab-asp                   |
| `web_app_name`          | [prefix]-lab-webapp          |
| `sku_name`              | B1                           |

Each student should choose a **unique web app name** since App Service names must be globally unique.

---

# Step 9 — Deploy the Infrastructure

Run the standard Terraform workflow:

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```
**OBS:** every time you need to make any update on the module code, you need to run `terraform init` in order to reinitialize the module 

Confirm the deployment when prompted.

After deployment, the **Linux Web App** should be visible in the Azure Portal.

---

# Step 10 — Validate the Deployment

Verify that the following resources were created:

* App Service Plan
* Linux Web App

You can also retrieve the **default web app URL** from the Azure portal and open it in a browser.

---

# Best Practices Reminder

During this lab, apply Terraform best practices:

* Keep modules **generic and reusable**
* Avoid hardcoded values inside modules
* Use **descriptive variable names**
* Separate configuration into logical files

Modules are essential when building **large Infrastructure as Code projects** because they:

* Improve **maintainability**
* Enable **code reuse**
* Standardize deployments across teams

---

# Wrap-Up

In this lab you implemented your **first Terraform module**.

You learned how to:

* Structure a Terraform project using modules
* Separate reusable infrastructure logic
* Deploy an **Azure App Service Plan and Linux Web App**
* Pass variables from the root configuration to a module

Terraform modules are a foundational concept for building **scalable, maintainable, and reusable Infrastructure as Code solutions**.

---

# Next Steps

To practice your learning with modules, you can challenge yourself to build some scenarios:
- Creating modules for new resources, or resource types that include a sequence (e.g., Network, including the creation of a Virtual Network and subnet)
- Creating multiple resources with the same module using repetition structures such as "count" or "for_each"
