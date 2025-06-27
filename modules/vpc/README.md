# Azure Private DNS Zone Module

This OpenTofu/Terraform module provisions an [Amazon Virtual Private Cloud] using the `aws` provider.

## Features

- Creates an AWS virtual private cloud 
- Outputs useful metadata like the DNS Zone ID and name.


## Usage

```
module "vpc" {
  source = "github.com/nikpapag/harness-iacm-demo/modules/vpc"
  name             = "harness-iacm-vpc"
  vpc_cidr         = "10.0.0.0/16"
  environment      = "dev"
  cost_center      = "INF"
  tag_owner        = "someuser"
  project          = "SE"
}
```

## Inputs

| Name                  | Description                              | Type          | Default | Required |
| --------------------- | ---------------------------------------- | ------------- | ------- | -------- |
| `name`                | The name of the VPC                 | `string`      | n/a     | ✅        |
| `vpc_cidr`                | The IP range for the VPC                 | `string`      | n/a     | ✅        |
| `environment` | Environment type | `string`      | n/a     | ✅        |
| `cost_center` | Cost Center used for chargeback | `string`      | n/a     | ✅        |
| `tag_owner`                | Owner of the VPC                          | `string` | n/a    |  ✅       |
| `project`                | Project code for showback                          | `string` | n/a    |  ✅       |


## Outputs

| Name            | Description                  |
| --------------- | ---------------------------- |
| `vpc_id`   | ID of the VPC   |


## Requirements
- OpenTofu or Terraform CLI
- AWS Provider ~> v6.0.0
- AWS account with permission to manage
