# Description of terraform-aws-secure-environment-accelerator solution
The AWS Secure Environment Accelerator is a tool designed to help deploy and operate secure multi-account, multi-region AWS environments on an ongoing basis. The power of the solution is the configuration file which enables the completely automated deployment of customizable architectures within AWS without changing a single line of code.
## Sample Design
![Architecture](./terraform_secure_environment_accelerator_diagram_sample.drawio.png)
### The module create AWS organisation which consist of:
#### 1. Root account, which creates 2 OUs
- Perimeter
- Networking
#### 2. 2 accounts inside OUs with same name as OUs
#### 3 Basic Networking setup
- 1 VPC in Networking account with 8 subnets
- Shared public subnets with Perimeter account
- VPC attached to a Transit Gateway with routes only for the private subnets
- 2 or 3 Nat gateways for high availability in Networking account, which will be used by other accounts to access to internet.
- Transit gateway in Networking account, which shares attachment and/or VPCs will share subnets with other accounts using 
Resource Access management
#### 4. SSO enabled
#### 5. Service control policies, which will add guardrails to restrict the usage of services in the linked accounts

The configuration of the organization structure is done by using the variable `organization_structure`, which
has the type of map.
The Map consist of keys containing the accounts. 
Each account has organizational unit `ou` and `email` and is positioned inside the OU. 
`create_ou` is important if you want to reuse existing OUs, please set it to false and pass ou_id to the `./modules/1_account` 
module
`cidr` is used for vpc cidr. Terraform calculates the subnets automatically. An example for 10.1.0.0/16:
```
tolist([
"10.1.0.0/24",
"10.1.1.0/24",
"10.1.2.0/24",
"10.1.3.0/24",
"10.1.4.0/28",
"10.1.4.16/28",
])
```
The first three are defined as public and the last three as private subnets
The email is used for the billing details:
```hcl
# EXAMPLE with nested accounts inside Backend organisational unit, which has production, integration and uat
variable "organization_structure" {
  type        = map(map(any))
  description = "The variable controls how the OUs and accounts will created\n The key of the map are the accounts, which will be created inside the ou, which is added as parameter"
  default = {
    networking = {
      email     = "martin.nanchev@adesso.bg"
      ou        = "Networking"
      cidr      = "10.1.0.0/16"
      create_ou = "true"
    }
    perimeter = {
      email     = "martin2754@icloud.com"
      ou        = "Perimeter"
      cidr      = "10.0.0.0/16"
      create_ou = "true"
    }
  }
}
```
# Deployment
```bash
cd `terraform-aws-secure-environment-accelerator`
terraform init && terraform apply --auto-approve
```
A Github Action was configured to perform terraform fmt check, terraform security check,terraform init and terraform plan
Terraform apply was commented out, but it was working during testing.
![Github Action](github_actions.png)
```yaml
name: 'Secure Environment Accelerator'

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  terraform:
    name: 'Terraform Deploy'
    runs-on: ubuntu-latest
    environment: production

    # Use the Bash shell regardless whether the GitHub Actions runner is ubuntu-latest, macos-latest, or windows-latest
    defaults:
      run:
        shell: bash

    steps:
      # Checkout the repository to the GitHub Actions runner
      - name: Checkout
        uses: actions/checkout@v2

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.REGION }}

      # Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
      - name: Terraform Init
        run: terraform init

      # Checks that all Terraform configuration files adhere to a canonical format
      - name: Terraform Format
        run: terraform fmt -check
      # Terraform Security check for vulnerabilities and code smells
      - name: Terraform security scan
        uses: triat/terraform-security-scan@v3.0.0

        # Generates an execution plan for Terraform
      - name: Terraform Plan
        run: terraform plan
```
# Future work
1. Add centralised Logging(Cloudtrail, CW, Config aggregator, etc to Logging account)
2. Add centralised Security(Macie, Guard Duty, Security hub, IAM Access analyser, etc)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.63.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_organization"></a> [organization](#module\_organization) | ./modules/0_organization | n/a |
| <a name="module_organization_accounts_structure"></a> [organization\_accounts\_structure](#module\_organization\_accounts\_structure) | ./modules/1_account | n/a |
| <a name="module_service_control_policy"></a> [service\_control\_policy](#module\_service\_control\_policy) | ./modules/2_scp | n/a |
| <a name="module_share_public_subnet_with_perimeter"></a> [share\_public\_subnet\_with\_perimeter](#module\_share\_public\_subnet\_with\_perimeter) | ./modules/5_ram | n/a |
| <a name="module_transit_gateway"></a> [transit\_gateway](#module\_transit\_gateway) | ./modules/4_transit_gateway | n/a |
| <a name="module_vpc_networking"></a> [vpc\_networking](#module\_vpc\_networking) | ./modules/3_vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_role"></a> [admin\_role](#input\_admin\_role) | n/a | `string` | `"AirTrafficControl"` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | n/a | `string` | `"sea"` | no |
| <a name="input_organization_structure"></a> [organization\_structure](#input\_organization\_structure) | The variable controls how the OUs and accounts will created<br> The key of the map are the accounts, which will be created inside the ou, which is added as parameter | `map(map(any))` | <pre>{<br>  "networking": {<br>    "cidr": "10.1.0.0/16",<br>    "create_ou": "true",<br>    "email": "martin.nanchev@adesso.bg",<br>    "ou": "Networking"<br>  },<br>  "perimeter": {<br>    "cidr": "10.0.0.0/16",<br>    "create_ou": "true",<br>    "email": "martin2754@icloud.com",<br>    "ou": "Perimeter"<br>  }<br>}</pre> | no |
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | `string` | `"profile"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

# Credits

For VPC and transit gateway implementations I used following modules:
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
https://registry.terraform.io/modules/terraform-aws-modules/transit-gateway/aws/latest
Spetial thanks to [@Anton Babenko]

