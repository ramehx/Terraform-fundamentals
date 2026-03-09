# Lab 2 — Deploying an Azure Virtual Machine with Terraform

## Objective

In this lab you will deploy an **Azure Virtual Machine** using **Terraform**.  
The goal is to practice writing Infrastructure as Code using **variables**, following basic **Terraform coding best practices**.

By the end of the lab you should be able to:

- Configure the Azure provider
- Declare and use Terraform variables
- Create an Azure Resource Group
- Deploy a Virtual Machine and its supporting network resources
- Use parameters to make the configuration reusable

You are expected to **write the Terraform configuration yourself**, using variables instead of hard-coded values.

> If you have doubts during the exercise, example lab files are available in this repository for reference.

---

# Region Assignment

To avoid hitting the **trial subscription quotas**, the class will distribute deployments across different regions.

Choose **ONE** of the following regions:

| Region |
|------|
| westeurope |
| northeurope |
| norwayeast |
| switzerlandnorth |
| canadacentral |

Important rules:

- Each student must **pick only one region**
- Coordinate with the other students
- **Maximum 2 students per region**

Example distribution for 9 students:

| Region | Students |
|------|------|
| westeurope | 2 |
| northeurope | 2 |
| norwayeast | 2 |
| switzerlandnorth | 2 |
| canadacentral | 1 |

---


# Terraform Best Practices

While implementing the solution, try to follow good Terraform development practices:

- Declare **all variables** in a `variables.tf` file
- Provide **description** and **type** for each variable
- Avoid hard-coding values in `main.tf`
- Use meaningful **resource names**
- Organize Terraform files properly

Typical file structure:

```text
terraform-vm-lab
│
├── main.tf
├── variables.tf
├── outputs.tf
└── providers.tf
```
---

# Required Infrastructure

Your Terraform configuration should deploy at least the following Azure resources:

- Resource Group
- Virtual Network
- Subnet
- Network Interface
- Virtual Machine

---

# Parameter Reference

Use the following parameters when implementing your configuration.

| Variable | Description | Example Value |
|------|------|------|
| prefix | Prefix used for naming resources | student1 |
| location | Azure region where resources will be deployed | northeurope |
| zone | Availability zone for the VM | 2 |
| vm_size | Azure VM size | Standard_B2ls_v2 |
| admin_username | Administrator username for the VM | azureuser |
| admin_password | Administrator password for the VM | Password123! |
| vnet_address_space | Address space for the Virtual Network | ["10.0.0.0/16"] |
| subnet_address_prefixes | Subnet CIDR range | ["10.0.1.0/24"] |
| os_type | Operating system type | Linux |
| os_disk_storage_account_type | Storage type for the OS disk | Standard_LRS |
| image_publisher | VM image publisher | Canonical |
| image_offer | VM image offer | 0001-com-ubuntu-server-jammy |
| image_sku | VM image SKU | 22_04-lts |
| image_version | Image version | latest |



---


# Special Constraint for West Europe

Due to **Azure Trial subscription constraints**, if you choose **westeurope** you must use the following parameters:

| Parameter | Required Value |
|------|------|
| zone | `1` |


For all other regions, use the default values provided in the parameter table above.


---


# Expected Outcome

At the end of this lab you should have:

- A working **Terraform configuration**
- All parameters defined as **variables**
- A successfully deployed **Azure Virtual Machine**
- A reusable and organized Terraform project
