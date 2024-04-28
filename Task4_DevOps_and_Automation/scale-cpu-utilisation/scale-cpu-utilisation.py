import boto3
import argparse

class AutoScalingGroup:
    def __init__(self, region, account_id):
        # Initialize the AWS clients for EC2, Auto Scaling, and CloudWatch
        self.region = region
        self.account_id = account_id
        self.ec2 = boto3.client('ec2', region_name=region)
        self.autoscaling = boto3.client('autoscaling', region_name=region)
        self.cloudwatch = boto3.client('cloudwatch', region_name=region)

    def create_launch_template(self, template_name, image_id, instance_type, key_name, security_group):
        # Create a launch template with the specified parameters
        response = self.ec2.create_launch_template(
            LaunchTemplateName=template_name,
            LaunchTemplateData={
                'ImageId': image_id,
                'InstanceType': instance_type,
                'KeyName': key_name,
                'SecurityGroupIds': [security_group],
            }
        )
        # Return the ID of the created launch template
        return response['LaunchTemplate']['LaunchTemplateId']

    def create_auto_scaling_group(self, group_name, launch_template_id, min_size, max_size, desired_capacity, subnet_ids):
        # Create an Auto Scaling group with the specified parameters
        self.autoscaling.create_auto_scaling_group(
            AutoScalingGroupName=group_name,
            LaunchTemplate={'LaunchTemplateId': launch_template_id},
            MinSize=min_size,
            MaxSize=max_size,
            DesiredCapacity=desired_capacity,
            VPCZoneIdentifier=','.join(subnet_ids)
        )

    def create_scaling_policy(self, policy_name, group_name, adjustment_type, adjustment_value):
        # Create a scaling policy with the specified parameters
        response = self.autoscaling.put_scaling_policy(
            AutoScalingGroupName=group_name,
            PolicyName=policy_name,
            PolicyType='SimpleScaling',
            ScalingAdjustment=adjustment_value,
            AdjustmentType=adjustment_type,
            Cooldown=300
        )
        # Return the ARN of the created scaling policy
        return response['PolicyARN']

    def create_cloudwatch_alarm(self, alarm_name, comparison_operator, evaluation_periods, metric_name, namespace, period, statistic, threshold, actions_enabled, alarm_actions ,group_name):
        # Create a CloudWatch alarm with the specified parameters
        self.cloudwatch.put_metric_alarm(
            AlarmName=alarm_name,
            ComparisonOperator=comparison_operator,
            EvaluationPeriods=evaluation_periods,
            MetricName=metric_name,
            Namespace=namespace,
            Period=period,
            Statistic=statistic,
            Threshold=threshold,
            ActionsEnabled=actions_enabled,
            AlarmActions=alarm_actions,
            Dimensions=[
            {
                'Name': 'AutoScalingGroupName',
                'Value': group_name
            },
        ]
        )

# Replace these with your actual values
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Create an Auto Scaling Group with scaling policies and CloudWatch alarms.')
    parser.add_argument('--region', required=True, help='AWS region')
    parser.add_argument('--account_id', required=True, help='AWS account ID')
    parser.add_argument('--template_name', required=True, help='Launch template name')
    parser.add_argument('--image_id', required=True, help='AMI ID')
    parser.add_argument('--instance_type', required=True, help='Instance type')
    parser.add_argument('--key_name', required=True, help='Key pair name')
    parser.add_argument('--security_group', required=True, help='Security group ID')
    parser.add_argument('--group_name', required=True, help='Auto Scaling group name')
    parser.add_argument('--min_size', type=int, required=True, help='Minimum size of the Auto Scaling group')
    parser.add_argument('--max_size', type=int, required=True, help='Maximum size of the Auto Scaling group')
    parser.add_argument('--desired_capacity', type=int, required=True, help='Desired capacity of the Auto Scaling group')
    parser.add_argument('--subnet_ids', nargs='+', required=True, help='Subnet IDs for the Auto Scaling group')
    parser.add_argument('--scale_out_policy_name', required=True, help='Scale Out policy name')
    parser.add_argument('--scale_in_policy_name', required=True, help='Scale In policy name')
    parser.add_argument('--scale_out_alarm_name', required=True, help='Scale Out CloudWatch alarm name')
    parser.add_argument('--scale_in_alarm_name', required=True, help='Scale In CloudWatch alarm name')
    parser.add_argument('--scale_out_comparison_operator', required=True, help='Scale Out Comparison operator for the CloudWatch alarm')
    parser.add_argument('--scale_in_comparison_operator', required=True, help='Scale In Comparison operator for the CloudWatch alarm')
    parser.add_argument('--scale_out_evaluation_periods', type=int, required=True, help='Scale Out Evaluation periods for the CloudWatch alarm')
    parser.add_argument('--scale_in_evaluation_periods', type=int, required=True, help='Scale In Evaluation periods for the CloudWatch alarm')
    parser.add_argument('--metric_name', required=True, help='Metric name for the CloudWatch alarm')
    parser.add_argument('--namespace', required=True, help='Namespace for the CloudWatch alarm')
    parser.add_argument('--scale_out_period', type=int, required=True, help='Scale Out Period for the CloudWatch alarm')
    parser.add_argument('--scale_in_period', type=int, required=True, help='Scale In Period for the CloudWatch alarm')
    parser.add_argument('--statistic', required=True, help='Statistic for the CloudWatch alarm')
    parser.add_argument('--scale_out_threshold', type=float, required=True, help='Scale Out Threshold for the CloudWatch alarm')
    parser.add_argument('--scale_in_threshold', type=float, required=True, help='Scale In Threshold for the CloudWatch alarm')
    parser.add_argument('--actions_enabled', type=bool, required=True, help='Whether actions are enabled for the CloudWatch alarm')
    parser.add_argument('--scale_out_adjustment_value', type=int, required=True, help='Scale out number of instances value')
    parser.add_argument('--scale_in_adjustment_value', type=int, required=True, help='Scale in number of instances value')


    args = parser.parse_args()
    # Create an AutoScalingGroup object

    asg = AutoScalingGroup(args.region, args.account_id)
    # Create a launch template   
    launch_template_id = asg.create_launch_template(args.template_name, args.image_id, args.instance_type, args.key_name, args.security_group)
    
    # Create an Auto Scaling group
    asg.create_auto_scaling_group(args.group_name, launch_template_id, args.min_size, args.max_size, args.desired_capacity, args.subnet_ids)
    
    # Create scaling policies
    scale_out_policy_arn = asg.create_scaling_policy(args.scale_out_policy_name, args.group_name, 'ChangeInCapacity', args.scale_out_adjustment_value)
    
    scale_in_policy_arn = asg.create_scaling_policy(args.scale_in_policy_name, args.group_name, 'ChangeInCapacity', args.scale_in_adjustment_value)
    
    # Create a high CPU utilization alarm
    high_cpu_alarm_actions = [scale_out_policy_arn]
    asg.create_cloudwatch_alarm(args.scale_out_alarm_name, args.scale_out_comparison_operator, args.scale_out_evaluation_periods, args.metric_name, args.namespace, args.scale_out_period, args.statistic, args.scale_out_threshold, args.actions_enabled, high_cpu_alarm_actions, args.group_name)

    # Create a low CPU utilization alarm
    low_cpu_alarm_actions = [scale_in_policy_arn]
    asg.create_cloudwatch_alarm(args.scale_in_alarm_name, args.scale_in_comparison_operator, args.scale_in_evaluation_periods, args.metric_name, args.namespace, args.scale_in_period, args.statistic, args.scale_in_threshold, args.actions_enabled, low_cpu_alarm_actions, args.group_name)