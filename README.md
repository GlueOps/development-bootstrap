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