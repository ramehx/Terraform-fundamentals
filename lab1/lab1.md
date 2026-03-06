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


## Terraform Installation

The official Terraform installation instructions can be found at:

https://developer.hashicorp.com/terraform/install

Terraform provides binaries for multiple operating systems.

---


## Installing Terraform on Windows

The typical installation process on Windows is:

1. Download the Terraform binary from the official website.
2. Extract the downloaded file to a directory, for example:

`C:\Terraform`


3. Add the directory to your **system PATH environment variable**.

Steps:

- Open **Edit system environment variables**
- Edit the **PATH** variable
- Add the folder:

`C:\Terraform`


4. Open a **PowerShell terminal** and run:

```bash
terraform -version
```

If Terraform is installed correctly, the version will be displayed.

---

## Recommended Development Environment

Although Terraform works on Windows, many engineers prefer working in a Linux environment.

A common setup is:

- WSL (Windows Subsystem for Linux) running Ubuntu 24.04

- VS Code as the development IDE

- Visual Studio Code

Download:

https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user

**Installing WSL**

Installation guide:

https://learn.microsoft.com/en-us/windows/wsl/install

Basic installation command:

```bash
wsl --install
```

---

## Installing Terraform on Linux (Ubuntu)

Run the following commands:

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform
```

Verify the installation:

```bash
terraform --version
```

**Install Azure CLI**

Terraform will interact with Azure using your authenticated session.

Install Azure CLI using:

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt

Example installation command:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

---
## Authenticate to Azure

Log in to your Azure tenant using:

```bash
# Ask your instructor the Tenant id
az login --tenant [TENANT_ID]
```

This command authenticates you with Azure so Terraform can deploy infrastructure in your subscription.

---

## Terraform Project Files

The repository contains a small demo Terraform project.
Create a folder and download the demo `lab1.tf` file from the repo.

**OBS:** For this lab, we are not using the standard file naming convention, nor will we go into detail about the code. The objective, for now, is to demonstrate the Terraform command flow for deploying the infrastructure.

---

## Terraform Workflow Commands

Terraform follows a standard workflow when managing infrastructure.

**Check Terraform Version**
```bash
terraform --version
```
Displays the installed Terraform version.
<img width="744" height="142" alt="image" src="https://github.com/user-attachments/assets/f7183e69-78ea-4bd6-928d-c8696ce59926" />



**Initialize Terraform**
```bash
terraform init
```
Initializes the Terraform project.

This command:

- Downloads required providers
- Creates the .terraform directory
- Generates the terraform.lock.hcl file

The terraform.lock.hcl file stores exact provider versions used by the project to ensure reproducible deployments.
<img width="630" height="344" alt="image" src="https://github.com/user-attachments/assets/68b865ae-08f1-4e79-b200-46e0f3e555d6" />


**Format the Code**
```bash
terraform fmt
```
Formats Terraform code according to standard conventions.
Running this command helps maintain consistent and readable code.

<img src="https://github.com/user-attachments/assets/eebe60a3-7bb6-48ac-affe-f9a5d3f55fb9" width="60%">


**Validate the Configuration**
```bash
terraform validate
```
Checks if the Terraform configuration is syntactically valid. This step helps detect errors before running a deployment.
<img width="1534" height="260" alt="image" src="https://github.com/user-attachments/assets/bab1ea06-35c3-4a54-9ced-71339c89f748" />


**Generate an Execution Plan**
```bash
terraform plan -out=plan1
```
This command creates a deployment plan.
**OBS:** you will be prompted to enter a value for *var.prefix*. This is intended to create an unique name for the storage account. Fill with a name of your preference.

The output shows:
- Resources that will be created
- Parameters used in the configuration
- Summary of changes

Example summary:
`Plan: X to add, 0 to change, 0 to destroy`

Saving the plan file allows you to apply exactly the same plan later.

<img src="https://github.com/user-attachments/assets/0241e791-509f-437b-92fe-c6f3f02fff2f" width="60%">

**Deploying the Infrastructure**

Before applying the plan, check the Azure portal and verify that the resources do not yet exist.

Run:
```bash
terraform apply
```
If no plan file is specified, Terraform will:

- Show the execution plan
- Ask for confirmation before deployment

When applying a saved plan:
```bash
terraform apply plan1
```
Terraform assumes you already reviewed the plan and will execute it immediately.

You may also see the option:

`-auto-approve`

This flag skips confirmation, but it is not recommended in production environments.

During deployment you will see:

- The creation order of resources
- Progress indicators
- A final summary

Example:
<img width="1131" height="383" alt="image" src="https://github.com/user-attachments/assets/3d5a07d9-f513-400b-93f9-6f39bfdf429f" />

After the deployment is finished, you will see an output with the URL of the blob created. Click on it to access / download the file. 
 
---

## Updating Infrastructure Through Code

One of Terraform’s key advantages is the ability to modify infrastructure by changing code.

In this step you will modify the configuration to enable static website hosting in the storage account.

This feature allows the storage account to host static web content.

Key concepts:

- The static_website block enables the feature
- The $web container is a special reserved container
- Files stored in this container can be served directly through a web endpoint

Copy the contents of the file `comp_static_html.txt` and paste it in your code immediately below the line containing `public_network_access_enabled = true` replacing all the code until the end (including the code related to creating the blob and the output). 

Run a new plan:
```bash
terraform plan -out=plan2
```
Observe the output carefully.

Some resources may be:

- Modified
- Destroyed and recreated
- Left unchanged

Apply the changes:
```bash
terraform apply plan2
```
After deployment, access the web endpoint from the Terraform outputs and open the static webpage.

Modify the HTML file (for example, replacing the rocket icon 🚀 with !!!) and run the Terraform workflow again to see how easily infrastructure updates can be applied.

## Destroying the Infrastructure

At the end of the lab you should destroy the deployed resources.

Preview the destroy plan:
```bash
terraform plan -destroy
```
Execute the destroy operation:
```bash
terraform destroy
```
You may also run:
```bash
terraform apply -destroy
```
The terraform destroy command is simply a shortcut for terraform apply -destroy.

Terraform will again request confirmation before deleting the infrastructure.

**OBS:** Always clean up resources after completing the lab to avoid unnecessary cloud consumption.

## Wrap-Up

In this lab, you learned how to install Terraform and execute the basic workflow to deploy infrastructure on Azure. You initialized a Terraform project, validated the configuration, generated an execution plan, and applied it to create resources.

These commands form the core Terraform lifecycle and are the foundation for managing infrastructure using Infrastructure as Code.

