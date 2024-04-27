**Explanation**

    1.   Created VPC with 2 public and private subnets.
    2.   Launched 1 ec2-instance in private subnet.
    3.   Created 1 security group for Load Balancer.
    4.   Created external Load Balancer in public subnet.

**Steps to Run**

1.  Move into respective folder(eg to create VPC): 

        ```
        cd vpc/
        ```
2.  Run below commands

        ```
        terraform init 
        terraform plan
        terraform apply
        ```        



