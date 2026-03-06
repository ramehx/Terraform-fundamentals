# Lab 1 — Terraform Installation and Basic Workflow

## Objective

In this lab you will install **Terraform** and learn the basic **Terraform workflow commands** used to manage infrastructure.

The goal is to understand how Terraform interacts with cloud platforms and how the typical execution flow works when deploying infrastructure.

By the end of this lab you should be able to:

- Install Terraform on your system
- Authenticate to Azure using the Azure CLI
- Initialize a Terraform project
- Validate and format Terraform code
- Generate and apply an infrastructure plan
- Update infrastructure through code changes
- Destroy deployed resources

Terraform works the same way regardless of the operating system you use.  
You may use **Windows, macOS, or Linux**, as long as Terraform and the Azure CLI are properly installed.

---

# Terraform Installation

The official Terraform installation instructions can be found at:

https://developer.hashicorp.com/terraform/install

Terraform provides binaries for multiple operating systems.

---

# Installing Terraform on Windows

The typical installation process on Windows is:

1. Download the Terraform binary from the official website.
2. Extract the downloaded file to a directory, for example:

`C:\Terraform`


3. Add the directory to your **system PATH environment variable**.

Steps:

- Open **Edit system environment variables**
- Edit the **PATH** variable
- Add the folder:

C:\Terraform


4. Open a **PowerShell terminal** and run:

```bash
terraform -version

---

If Terraform is installed correctly, the version will be displayed.

---

# Recommended Development Environment

Although Terraform works on Windows, many engineers prefer working in a Linux environment.

A common setup is:

WSL (Windows Subsystem for Linux)

VS Code as the development IDE

Visual Studio Code

Download:

https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user

Installing WSL

Installation guide:

https://learn.microsoft.com/en-us/windows/wsl/install

Basic installation command:

```bash
wsl --install


Installing Terraform on Linux (Ubuntu)

Run the following commands:

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform

Verify the installation:

terraform --version


Install Azure CLI

Terraform will interact with Azure using your authenticated session.

Install Azure CLI using:

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt

Example installation command:

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

Authenticate to Azure

Log in to your Azure tenant using:

az login --tenant bc78bae8-8710-4ff1-9311-bf428b16671e

This command authenticates you with Azure so Terraform can deploy infrastructure in your subscription.

Terraform Project Files

The repository contains a small demo Terraform project.

Before running Terraform commands, review the project files and understand their purpose.

Typical Terraform project structure:

terraform-demo
│
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
File roles
File	Purpose
main.tf	Defines infrastructure resources
variables.tf	Declares input variables
terraform.tfvars	Provides values for variables
outputs.tf	Defines outputs returned after deployment
Terraform Workflow Commands

Terraform follows a standard workflow when managing infrastructure.

Check Terraform Version
terraform --version

Displays the installed Terraform version.

Initialize Terraform
terraform init

Initializes the Terraform project.

This command:

Downloads required providers

Creates the .terraform directory

Generates the terraform.lock.hcl file

The terraform.lock.hcl file stores exact provider versions used by the project to ensure reproducible deployments.

Format the Code
terraform fmt

Formats Terraform code according to standard conventions.

Running this command helps maintain consistent and readable code.

Validate the Configuration
terraform validate

Checks if the Terraform configuration is syntactically valid.

This step helps detect errors before running a deployment.

Generate an Execution Plan
terraform plan -out=plan1

This command creates a deployment plan.

The output shows:

Resources that will be created

Parameters used in the configuration

Summary of changes

Example summary:

Plan: X to add, 0 to change, 0 to destroy

Saving the plan file allows you to apply exactly the same plan later.

Deploying the Infrastructure

Before applying the plan, check the Azure portal and verify that the resources do not yet exist.

Run:

terraform apply

If no plan file is specified, Terraform will:

Show the execution plan

Ask for confirmation before deployment

Example prompt:

Do you want to perform these actions?

When applying a saved plan:

terraform apply plan1

Terraform assumes you already reviewed the plan and will execute it immediately.

You may also see the option:

-auto-approve

This flag skips confirmation, but it is not recommended in production environments.

During deployment you will see:

The creation order of resources

Progress indicators

A final summary

Example:

Apply complete! Resources: X added, 0 changed, 0 destroyed.
Updating Infrastructure Through Code

One of Terraform’s key advantages is the ability to modify infrastructure by changing code.

In this step you will modify the configuration to enable static website hosting in the storage account.

This feature allows the storage account to host static web content.

Key concepts:

The static_website block enables the feature

The $web container is a special reserved container

Files stored in this container can be served directly through a web endpoint

Run a new plan:

terraform plan -out=plan2

Observe the output carefully.

Some resources may be:

Modified

Destroyed and recreated

Left unchanged

Apply the changes:

terraform apply plan2

After deployment, access the web endpoint from the Terraform outputs and open the static webpage.

Modify the HTML file (for example replacing the rocket icon with !!!) and run the Terraform workflow again to see how easily infrastructure updates can be applied.

Destroying the Infrastructure

At the end of the lab you should destroy the deployed resources.

Preview the destroy plan:

terraform plan -destroy

Execute the destroy operation:

terraform destroy

You may also run:

terraform apply -destroy

The terraform destroy command is simply a shortcut for terraform apply -destroy.

Terraform will again request confirmation before deleting the infrastructure.

Always clean up resources after completing the lab to avoid unnecessary cloud consumption.
