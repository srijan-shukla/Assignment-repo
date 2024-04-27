Auto Scaling Group Creation Script
This Python script allows you to create an Auto Scaling Group (ASG) with scaling policies and CloudWatch alarms in AWS. The ASG will automatically scale EC2 instances based on CPU utilization.

Working

Each function in the class AutoScalingGroup is responsible for a specific task related to creating and configuring an Auto Scaling group in AWS. The create_launch_template function creates a launch template, which is a configuration template that an Auto Scaling group uses to launch EC2 instances. The create_auto_scaling_group function creates the Auto Scaling group itself. The create_scaling_policy function creates a scaling policy, which determines how the Auto Scaling group should scale in response to changing demand. Finally, the create_cloudwatch_alarm function creates a CloudWatch alarm, which triggers the scaling policy when certain conditions are met.

Requirements
Python 3.x
Boto3 library installed (pip install boto3)
AWS CLI configured with appropriate permissions

Usage
You can run the script from the command line with the following syntax:

python3 scale-cpu-utilisation.py --region <region> --account_id <account_id> --template_name <template_name> --image_id <image_id> --instance_type <instance_type> --key_name <key_name> --security_group <security_group> --group_name <group_name> --min_size <min_size> --max_size <max_size> --desired_capacity <desired_capacity> --subnet_ids <subnet_id1> <subnet_id2> --scale_out_policy_name <scale_out_policy_name> --scale_in_policy_name <scale_in_policy_name> --scale_out_alarm_name <scale_out_alarm_name> --scale_in_alarm_name <scale_in_alarm_name> --scale_out_comparison_operator <scale_out_comparison_operator> --scale_in_comparison_operator <scale_in_comparison_operator> --scale_out_evaluation_periods <scale_out_evaluation_periods> --scale_in_evaluation_periods <scale_in_evaluation_periods> --metric_name <metric_name> --namespace <namespace> --scale_out_period <scale_out_period> --scale_in_period <scale_in_period> --statistic <statistic> --scale_out_threshold <scale_out_threshold> --scale_in_threshold <scale_in_threshold> --actions_enabled <actions_enabled> --scale_out_adjustment_value <scale_out_adjustment_value> --scale_in_adjustment_value <scale_in_adjustment_value>

Replace <placeholders> with actual values.

Parameters
region: AWS region
account_id: AWS account ID
template_name: Launch template name
image_id: AMI ID
instance_type: Instance type
key_name: Key pair name
security_group: Security group ID
group_name: Auto Scaling group name
min_size: Minimum size of the Auto Scaling group
max_size: Maximum size of the Auto Scaling group
desired_capacity: Desired capacity of the Auto Scaling group
subnet_ids: Subnet IDs for the Auto Scaling group (space-separated if multiple)
scale_out_policy_name: Scale Out policy name
scale_in_policy_name: Scale In policy name
scale_out_alarm_name: Scale Out CloudWatch alarm name
scale_in_alarm_name: Scale In CloudWatch alarm name
scale_out_comparison_operator: Scale Out Comparison operator for the CloudWatch alarm
scale_in_comparison_operator: Scale In Comparison operator for the CloudWatch alarm
scale_out_evaluation_periods: Scale Out Evaluation periods for the CloudWatch alarm
scale_in_evaluation_periods: Scale In Evaluation periods for the CloudWatch alarm
metric_name: Metric name for the CloudWatch alarm
namespace: Namespace for the CloudWatch alarm
scale_out_period: Scale Out Period for the CloudWatch alarm
scale_in_period: Scale In Period for the CloudWatch alarm
statistic: Statistic for the CloudWatch alarm
scale_out_threshold: Scale Out Threshold for the CloudWatch alarm
scale_in_threshold: Scale In Threshold for the CloudWatch alarm
actions_enabled: Whether actions are enabled for the CloudWatch alarm (True or False)
scale_out_adjustment_value: Scale out number of instances value
scale_in_adjustment_value: Scale in number of instances value



Example

python3 scale-cpu-utilisation.py --region us-west-2 --account_id 123456789012 --template_name my-launch-template --image_id ami-0abcdef1234567890 --instance_type t4g.medium --key_name my-key-pair --security_group sg-0abcdef1234567890 --group_name my-auto-scaling-group --min_size 1 --max_size 5 --desired_capacity 1 --subnet_ids subnet-0abcdef1234567890 subnet-0abcdef0987654321 --scale_out_policy_name scale-out-policy --scale_in_policy_name scale-in-policy --scale_out_alarm_name high-cpu-alarm --scale_in_alarm_name low-cpu-alarm --scale_out_comparison_operator GreaterThanThreshold --scale_in_comparison_operator LessThanThreshold --scale_out_evaluation_periods 2 --scale_in_evaluation_periods 2 --metric_name CPUUtilization --namespace AWS/EC2 --scale_out_period 60 --scale_in_period 120 --statistic Average --scale_out_threshold 70.0 --scale_in_threshold 30.0 --actions_enabled True --scale_out_adjustment_value 1 --scale_in_adjustment_value -1

This example creates an ASG with a minimum size of 1 and a maximum size of 5, with a desired capacity of 1. It also creates scaling policies and CloudWatch alarms for high and low CPU utilization.