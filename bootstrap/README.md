## infra setup for all apps

This will create the resources required to prop up infrastructure. 

1. create `infra-bootstrap` aws user with the following permission policy:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
```

2. Using the `infra-bootstrap` user, use the terraform plan in the bootstrap directory to create the limited IAM users that will set up everything else:
```bash
aws configure --profile bootstrap
terraform init 
terraform plan 
terraform apply

# deactivate access for the infra-bootstrap user after usage
```

3. Once IAM users are created, navigate to infrastructure directory and run terraform there:
```bash
# adds the two just created limited aws users that will set up infrastructure
aws configure --profile github_deploy
aws configure --profile terraform
```