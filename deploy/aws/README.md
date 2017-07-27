# AWS ECS Willow deployment


1. Create ECRs: `willow-solr`, `willow-fedora`, `willow-redis` and `willow-app`
2. Build Willow using Docker Compose or another way (e.g. Ansible playbook with docker-py).
3. Push to ECRs (2 options):

    a. If using Ansible with docker-py, this gives you a few attributes which allow you to specify that pushing should happen after building. ECR URL to push to is specified in the env vars in this case.

    b. Or, use the manual option. Once you build the Docker images, this should be run in the same build environment:

    ```
    # assuming logged into AWS and able to push to ECR
    docker tag <local image reference> <ECR URL/repo-name:tag>
    # e.g.
    # docker tag cottagelabs/willow-solr 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-solr:latest
    
    docker push <ECR URL/repo-name:tag>
    # e.g.
    # docker push 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-solr:latest
    ```

1. Make sure ECS is fully set up on the AWS account (special role is created, you're happy with the VPC, networking and security group setup, and ECS-capable instances are provisioned).

1. Make sure RDS is set up. You will need the host, username and password variables for Postgres in the next step.

1. Create a task definition using the `sample-willow-taskdef.json` in this folder. Search for all instances of `REPLACE` and replace them with suitable values, usually random generated credentials. Finally, decide on memory constraints - suitable guesstimates of `memory` and `memoryReservation` are in place in the sample task definition.

1. Create an ECS service running the Willow task with a desired count of 1.

1. Willow should be running on ECS.