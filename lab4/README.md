# Lab 4 — Implementing Terraform Modules with Azure Containers
**Lab Overview** 

In this lab, you will learn how to create and use Terraform modules to deploy reusable infrastructure components.

Instead of defining all resources in a single Terraform configuration, we will encapsulate infrastructure logic inside a Terraform module and deploy it from a root module.

The module created in this lab will provision:

An Azure Container Registry (ACR) to store container images

An Azure Container Instance (ACI) that runs a container workload

By the end of the lab, you will deploy a containerized application using a reusable Terraform module and retrieve the public endpoint of the running container.
