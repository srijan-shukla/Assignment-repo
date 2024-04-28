# Deploying a Sample Application on EKS Cluster

This guide will walk you through the steps to configure an EKS cluster using Terraform and deploy a sample application with high availability and rolling updates.

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed
- Helm installed
- kubectl installed
- docker installed

## Steps

### 1. Configure EKS Cluster , ECR ,iam-roles-serviceaccount, NAMESPACE using Terraform

Navigate to respective directiories and then run below commands. For eg. to create eks cluster:

    ```
    cd terraform/
    terraform init
    terraform apply

    ```

### 2. Build the image and Push  to AWS ECR:

Navigate to flask-calculator-app directory:
    
    ```
    cd flask-calculator-app/
    ```
    
    run below commands to build and push to AWS ECR
    ```
    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <your-aws-account-id>.dkr.ecr.ap-south- 
    1.amazonaws.com
    docker build -t flask-calculator-app/prod .
    docker tag flask-calculator-app/prod:latest <your-aws-account-id>.dkr.ecr.ap-south-1.amazonaws.com/flask-calculator-app/prod:latest
    docker push <your-aws-account-id>.dkr.ecr.ap-south-1.amazonaws.com/flask-calculator-app/staging1:latest
    ```

### 3. Install AWS ALB Ingress Controller, Cluster Autoscaler, Metrics Server, and Flask Calculator App using Helm

Get Kubeconfig file for logging in to the cluster by running below command:

    ```
    aws eks --region ap-south-1 update-kubeconfig --name prod-fca
    ```

Navigate to the Helm charts directory in your workspace. and install the all 4 components bu runing following commands:

    ```
    cd helm-charts/
    helm install -f ../helm-values/aws-alb-controller aws-alb-controller ./aws-alb-controller -n prod --set iamrole.awsAccountId=<your-aws-account-id>
    
    helm install -f ../helm-values/cluster-autoscaler cluster-autoscaler ./cluster-autoscaler -n prod  --set iamrole.awsAccountId=<your-aws-account-id>

    helm install -f ../helm-values/metrics-server metrics-server ./metrics-server -n prod

    helm install -f ../helm-values/flask-calculator-app flask-calculator-app ./flask-calculator-app -n prod  --set certificatearn=<your-aws-account-id> --set security-group-id=<security-group-id> --set image.repository.awsAccountId=<your-aws-account-id> --set image.tag=<your-image-tag>
    ```

### 4. High Availability and Rolling Updates

The following steps have been taken to implement high availability and rolling updates:

1. The application is deployed on an EKS cluster in to 2 different subnets across multiple availability zones and on-demand nodes.
2. The application is configured with multiple replicas to ensure high availability.
3. The Metrics Server is used to send metrics to HPA.
4. The Cluster Autoscaler is used to automatically scale the number of replicas based on the CPU load.
5. The AWS ALB Ingress Controller is used to distribute traffic evenly across all the replicas.
6. The PodDisruptionBudget is used with maxUnavailable=1 so that at most 1 pod can be made unavailable during rebalancing actvities.
7. The PodAntiaffinity is used so that 2 pods of the application doesn't get scheduled on the same node.
8. Liveliness and Readiness Probes are configured with InitialDelaySeconds=50 so that the application gets enough time for starting

9. Rolling updates are configured for the application with :
   
        maxSurge=25%. This is useful for ensuring that there are enough new pods available to handle incoming traffic while the old pods are being replaced.

        maxUnavailable=25%.  This ensure that only 25% of pods of total current replicas can be unavailable during the update process.
