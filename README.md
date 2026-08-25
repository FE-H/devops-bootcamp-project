# Terraform Infrastructure Setup Guide
Welcome to the infrastructure provisioning guide for the devops-bootcamp-project. This guide covers how to initialize, plan, and apply our modular Terraform configuration located inside the terraform/ subdirectory.

## 📂 Directory Structure Overview
Inside the terraform/ folder, our configuration is broken down into clean, manageable files:

providers.tf — Configures the cloud provider (AWS) and required versions.

network.tf — Sets up VPCs, subnets, internet gateways, and route tables.

security.tf — Defines security groups and firewall rules.

ec2.tf — Provisions our EC2 instances.

outputs.tf — Exposes important attributes like public IPs and endpoints.

userdata.sh & userdata-tunnel.sh — Automation scripts for bootstrapping our instances on startup.

## ⚙️ Step-by-Step Deployment Instructions
### 1. Navigate to the Terraform Directory
Open your terminal and move into the Terraform working directory:

Bash
`cd terraform/`
### 2. Initialize Terraform (terraform init)
This command initializes our working directory, downloads the required provider plugins (such as the AWS provider), and sets up the backend.

Bash
`terraform init`
Note: Always run init when cloning the repo for the first time or whenever you modify your provider requirements.

### 3. Preview the Infrastructure (terraform plan)
Before making any changes to our cloud environment, let's generate and review an execution plan. This acts as a dry-run to show us exactly what resources Terraform will create, modify, or destroy.

Bash
`terraform plan -out=tfplan`
Review the output carefully to ensure the instance types, networking, and security groups match your project requirements.

### 4. Apply the Configuration (terraform apply)
Once you are satisfied with the execution plan, deploy the infrastructure by applying the saved plan:

Bash
`terraform apply tfplan`
Terraform will begin provisioning the networking, security groups, and EC2 instances using our userdata.sh scripts.

This process usually takes a couple of minutes.

### 5. Verify Outputs
Once the apply phase completes successfully, Terraform will display the outputs defined in outputs.tf (such as the server public IPs). If you need to view them later, simply run:

Bash
`terraform output`
### 🧹 Cleanup
To avoid unexpected cloud costs after your final presentation, remember to tear down your infrastructure cleanly using:

Bash
`terraform destroy`