# Terraform Assessment Project

Project contains Terraform IAC which is used to deploy a PHP webpage in an EC2 Instance. The Webpage displays the instance Hostname through an Aws Loadbalancer in an Autoscaling group.

## Table of Contents

- [Terraform Assessment Project](#terraform-assessment-project)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
  - [Directory Structure](#directory-structure)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Usage](#usage)
    - [Configuration](#configuration)
    - [Commands](#commands)
    - [Cleaning Up](#cleaning-up)

## Getting Started

The Folder contains a terraform configuration files which call terraform modules defined in the `modules` directory. The Modules are used to deploy the different resources to deploy the Php Web Page

## Directory Structure
```
.
├── README.md
├── config.yaml
├── locals.tf
├── main.tf
└── modules
    ├── alb
    │   ├── README.md
    │   ├── ...
    │   └── versions.tf
    ├── asg
    │   ├── README.md
    │   ├── ...
    │   └── versions.tf
    └── vpc
        ├── README.md
        ├── ...
        └── versions.tf


```
- vpc: This is used to create the VPC infrastruture. based on the AWS VPC Terraform module. See Module directory Readme for Resources that the Module deploys
- Asg: This deploys the autoscaling group, Security groups and scaling policies for running the application
- ALB: This deploys the Loadbalancer and the supporting resources.

### Prerequisites

- Terraform Binary. Project supports all versions after 1.0
- AWS Credentials. Run `aws configure` to ensure Terraform deploys to the right aws environment
- Git to Clone this repository. 
```
git clone <repository_name>
```

### Installation

Initialize the project by cloning the repository and running the initilization command in the root directory.

```bash
git clone <repo>
cd <repository>
terraform init
```

## Usage

### Configuration

Modules can be configured using the `config.yaml` file. The Configuration Options are listed below. Only the customer name is required; the optional fields are populated in the Terraform module if not defined.

```
customer: "<Name of Assessment Required>"
vpc_cidr: "10.0.0.0/16" # Optional
region: "eu-west-1"    # Optional

ec2_instance:
  name: asg-demo       # Optional
  ami_id: null         # Optional
  port: 80             # Optional
  type: "t3.small"     # Optional
  scaling_cpu: 60.0    # Optional
  min_size: 1          # Optional
  max_size: 3          # Optional
  desired_size:  1      

alb_scaling:           # Optional
  enabled: true        # Optional
  request_count: 1000  # Optional

tags:
  Customer: seyi       # Optional
```

### Commands

To run the project, follow these commands:

- **Initialize the project:**
  ```bash
  terraform init
  ```

- **Preview the changes:**
  ```bash
  terraform plan
  ```

- **Apply the changes:**
  ```bash
  terraform apply
  ```



The Loadbalancer DNS Name is shown at the end of the apply command, This can be used to access the Webpage

### Cleaning Up
To cleanup the resources from the AWS account, Run the Command
- **Destroy resources:**
  ```bash
  terraform destroy
  ```