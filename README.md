# centralized terraform repo

## how to prop it up

inside any of the app directories:

1. prop up the ecr repo as the rest of the services cannot start without a repository and image: 
```bash
# switch project_name
terraform apply -target=aws_ecr_repository.<project-name> 

## this will only create the ecr repo out of all desired services
```


2. push desired image
```bash
# replace region, aws profile and account id
aws ecr get-login-password --region <region> --profile <profile with permissions> | docker login --username AWS --password-stdin <your_account_id>.dkr.ecr.us-east-1.amazonaws.com

docker build -t <app-name> .
docker tag angular-app:latest <ecr_repo_url>:latest
docker push <ecr_repo_url>:latest
```

3. once the image exists, the rest of the infrastructure can be built
```bash
terraform plan
terraform apply
```
## how to take it down 

```bash
terraform destroy # it may take down resources you would like to not have to recreate like secrets/image registries
```

## example of how to take it down excluding the ECR

```bash
terraform destroy -target=aws_ecs_cluster.angular \
                  -target=aws_ecs_task_definition.angular \
                  -target=aws_lb.angular \
                  -target=aws_lb_target_group.angular\
                  -target=aws_lb_listener.angular \
                  -target=aws_ecs_service.angular
```

to find a list of resources for a given project: 
```bash
terraform state list | grep <project-name or project-tag>
```