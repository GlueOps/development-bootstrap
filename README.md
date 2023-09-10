# Development Bootstrap

### Creating the AMI
Run Packer with AWS cloud provider keys and with necessary values to create an AMI. 

```
cd ./packer
packer build ec2.json
```

### Launching the VM
Run the terraform module with AWS cloud provider keys, to create the VM from the AMI from above.

```
cd ./terraform 
terraform plan 
terraform apply
```
Note: use the AMI id from the previous step as input for terraform.

### Glueops Setup 

1. Login to the machine with given ssh keys 
2. Run gh auth to login to your Github account 
```
# Run the gh auth login command and enter the code in your local machine browser.

yes Y | gh auth login -h github.com -p https -w -s repo,workflow,admin:org,write:packages,user,gist,notifications,admin:repo_hook,admin:public_key,admin:enterprise,audit_log,codespace,project,admin:gpg_key,admin:ssh_signing_key

gh auth setup-git
```
3. git clone https://github.com/development-captains/test-80-np.venkata.onglueops.rocks 
```
cd test-80-np.venkata.onglueops.rocks

# Install argocd
helm repo add argo https://argoproj.github.io/argo-helm
source <(curl -s https://raw.githubusercontent.com/GlueOps/development-only-utilities/v0.4.1/tools/glueops-platform/deploy-argocd) && deploy-argocd -c v2.7.11 -h 5.42.2

# Install Glueops
source <(curl -s https://raw.githubusercontent.com/GlueOps/development-only-utilities/v0.4.1/tools/glueops-platform/deploy-glueops-platform) && \
    deploy-glueops-platform -v v0.30.0
```

