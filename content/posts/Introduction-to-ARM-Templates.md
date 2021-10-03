---
title: "Introduction to ARM Templates"
date: 2020-08-01T08:19:17-04:00
draft: false
toc: false 
tags:  
  - Azure
  - ARM Templates
  - CI/CD Pipelines
  - Cloud Infrastructure
  - Azure DevOps
---
Short-hand:  
  - ARM - Azure Resource Manager
  - Azure DevOps - ADO
  - CI/CD Pipelines - CI\CD

## Introduction

In this blog I will talk about Azure Resource Manager (ARM) templates and how we can implement them into a CI\CD pipeline in Azure DevOps. First, I will give a high level overview of ARM architecture and then I will dig into how we can automate cloud infrastructure using ARM templates in an orchestration tool such as Azure DevOps. Let's start by giving an overview of ARM templates.

## ARM Templates Overview

![Image0](/img/IntroductionToARMTemplates/image0.png)

With the technology world moving faster than ever, a lot of organizations have adopted the agile development methodology. As organization want to ship code faster they need a way to deploy infrastructure consistently and reliably throughout their environments. With the DevOps movement, organizations have torn down the silos between teams such as IT and Development. Now the infrastructure and application developments are in a single unified process. 

This is where Azure Resource Manager (ARM) templates come into play. ARM Templates give us a was to define out infrastructure as code. This aligns with the agile methodology by being consistent and reliable when deploying our infrastructure across multiple environments such as DEV, QA, UAT and Production. Since build infrastructure is now part of the Software Development Life Cycles we can store the ARM Templates infrastructure as code into repositories and iterate over them when new requirements are handed down. 

This allows for any team member on either the infrastructure or application team to deploy infrastructure changes at any given time. ARM Templates is a JavaScript Object Notation (JSON) file that defines the Infrastructure and configuration for your environments. The syntax is declarative and allows you to state what you intend to deploy without having to write the programming commands to provisioned the infrastructure. Now that we have a basic understanding of ARM templates, lets dig into the architecture of the Azure Resource Manager. 

## Azure Resource Manager Architecture

I want to start by saying modern Azure functionality is build on Azure Resource Manager ARM and Azure deployment services. Prior to Azure Resources Manager there was an Azure Service manager(ASM). This service was limited and is why Microsoft created Azure Resource Manager(ARM). With ARM, all APIs and management interfaces operate by using the ARM layer in Azure. One of the biggest differences between ARM and ASM is ARM gives us the ability to run parallel operations at once. Additionally, ARM includes the following:
  - Azure PowerShell
  - Azure CLI
  - REST APIs
  - SDKs
  - Azure AD
  - Azure Authentication

 ARM uses a declarative concept, which means you tell ARM what you want in an ARM template and then the Azure ARM layer provisions those resources. For example, if we need to provision a VM inside of a Virtual Network we would write the declarative state in the ARM template. The Azure ARM layer knows that VMs have a network dependency and would build the network prior to provisioning the VM. 

![Image1](/img/IntroductionToARMTemplates/image1.png)

Keep in mind since ARM is using a declarative state that means if we run the template once it will provision the resources specified in the ARM template. Now if we run the template a second time it will not re-provision those resources, unless there is a change to the ARM template modifying the existing resources or adding new ones. All the Azure resource types are provided by Azure resource providers. These resources types are then specified in the ARM template depending on which type of resource type you want to provision. 

To view resource types, Azure provides a tool called Azure Resource Explorer which allows you to view all resources types. 

Azure Resource Explorer - https://azure.microsoft.com/en-us/blog/azure-resource-explorer-a-new-tool-to-discover-the-azure-api/

Resources are an important component when it comes to ARM templates. They will be used as building blocks when building out your infrastructure. Resources will often reference other resources and depend on other resources in Azure. For example, lets same we want to provision a VM in Azure. VMs are dependent on disks to be provisioned first then mounted to the VM. So the in this case the VM is dependent on the disk. Depending how you build out you infrastructure you will have many dependencies on various Azure resources. 

![Image2](/img/IntroductionToARMTemplates/image2.png)

All the configurations done to your ARM templates are in JSON format and deployments are internally stored in a JSON file in an ARM template. JSON format is easy to read and to understand. I would prefer the template format to be in YAML but I digress. Each resource group in Azure has an option to export the ARM template. If you navigate to a resource group and click on 'Export Template' under the settings pane you will see the ARM template in JSON format. 

Resource groups offer us logical buckets to place our resources in. Resource groups are fundamental to ARM templates. Resources groups provide various benefits which are outlined below:
  - We should group resources with the same or similar lifecycle together.
  - Role based access control is typically applied at the resource group level. 
  - Policies are applied at the resource group level.
  - Tags can be applied and configured at the resource group level. 

**Please note, resources can only be placed in one resources group. You can not have a single resource attached to multiple resource groups.**

## ARM Templates 

In this section we will cover the structure of an ARM template, various sources of ARM templates, template deployment process and Azure portal ARM template repositories. Lets start by talking about the ARM template structure. 

### ARM Template Structure

