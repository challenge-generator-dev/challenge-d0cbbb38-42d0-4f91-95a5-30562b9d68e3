# Terraform Module: API Gateway + Lambda Integration

## Overview
This module provisions an AWS API Gateway REST API integrated with Lambda functions. It is structured for multi-environment deployment (e.g., dev, staging, prod) using Terraform workspaces or environment-specific configurations.

## Structure
```
.
├── environments/
│   └── dev/                  # Environment-specific configurations
│       ├── main.tf           # Root module instantiation
│       ├── terraform.tfvars  # Environment variables
│       └── variables.tf      # Input variables for the environment
├── modules/
│   ├── api_gateway/          # API Gateway module
│   │   ├── main.tf           # Resource definitions
│   │   ├── variables.tf      # Input variables
│   │   └── outputs.tf        # Output values
│   └── lambda/               # Lambda module
│       ├── main.tf           # Resource definitions
│       ├── variables.tf      # Input variables
│       └── outputs.tf        # Output values
├── providers.tf              # Provider configurations
├── versions.tf               # Terraform version constraints
└── tests/                    # Test files
    └── acceptance/           # Acceptance tests
        └── f2.tftest.hcl     # Test definitions
```

## Prerequisites
- Terraform 1.5.7+
- AWS CLI configured with credentials
- AWS provider version 5.x

## Setup
1. **Initialize Terraform**:
   ```bash
   cd environments/dev
   terraform init
   ```

2. **Plan Deployment**:
   ```bash
   terraform plan
   ```

3. **Apply Changes**:
   ```bash
   terraform apply
   ```

## Validation
- **Local Validation**:
  ```bash
  terraform validate
  ```

- **Acceptance Tests**:
  ```bash
  terraform test
  ```

## Inputs
Refer to `environments/dev/variables.tf` and module-specific `variables.tf` files for required inputs.

## Outputs
After deployment, outputs are available in the Terraform state. Refer to module-specific `outputs.tf` files for details.

## Notes
- Ensure AWS credentials have sufficient permissions for API Gateway, Lambda, and IAM.
- Environment-specific variables should be defined in `terraform.tfvars`.