# osbuild-gitops
This is a simple example demonstrating building bootable OS images with osbuild. Repo currently contains a osbuild blueprint template to build a RHEL9 base bootable system image for demonstration purposes. Keep in mind this is just an example to demonstrate use of best practices and its intended to be a reference for infrastructure teams.

## Required Repository Variables and Secrets
This section covers repository variables and secrets used in the github actions CI workflow for building RHEL system 

Table below shows repository variables that need to be setup.

Variable Name | Purpose                       |
------------  | -------                       |
ADMIN_USER    | Non root admin user account   |

Table nelow shows repository secrets that need to be setup 

Secret                  | Purpose                                           |
----------              | --------------------                              |
ROOT_USER_KEY           | SSH key to be set for root user account           |
ADMIN_USER_PASSWORD     | Password to be used for non root admin account    |
ADMIN_USER_KEY          | SSH key for local admin user                      |

## Setting up a self hosted runner
We are going to use a RHEL 9 system with image builder and all required tools installed and configured as a self hosted github actions runner within the github actions workflow. 

### Provisioning self hosted runner infrastructure
For demonstration purposes I'm using an EC2 instance in Amazon and have included a Terraform script to provision the required infrastructure resources in AWS.

```bash
terraform init
terraform plan
terraform apply
```
### Configuring the self hosted runner