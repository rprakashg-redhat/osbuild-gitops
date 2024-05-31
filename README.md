# osbuild-gitops
This is a simple example demonstrating building RHEL system images using image builder and Gitops process. Keep in mind this is just an example to demonstrate use of best practices and its intended to be a reference for infrastructure teams.

## Setting up a self hosted runner
We are going to use a RHEL 9 system with image builder and all required tools installed and configured as a self hosted github actions runner within the github actions workflow. 

### Provisioning self hosted runner infrastructure
For demonstration purposes I'm using an EC2 instance in Amazon and have included a Terraform script to provision the required infrastructure resources in AWS.

```bash
cd runner/provision

terraform init
terraform plan
terraform apply
```
### Configuring the self hosted runner
We are going to use Ansible to configure the self hosted runner. Switch to configure directory 

```
cd ../configure
```

Running the terraform provisioning scripts as shown above would have outputed public DNS of EC2 instance after it was complete, copy that and update the inventory file under runner/configure directory

Use ansible-vault to create an encrypted secrets file and include yaml snippet shown below

```
ansible-vault create configure/vars/secrets.yml
```
Incude yaml snippet shown below, be sure to specify your redhat credentials

```yaml
rhUser: '<specify>'
rhPassword: '<specify>'
```


store the vault secret in VAULT_SECRET environment variable as shown below

```
export VAULT_SECRET=<specify>
```

Run the playbook to configure the self hosted runner 

```
ansible-playbook -vvi inventory --vault-password-file <(echo "$VAULT_SECRET") configure-runner.yaml
```

## Start the actions runner
Next thing we need to do is start the runner


```
cd actions_runner

./run.sh
```

Kick off the pipeline 