resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_name        = "ayoub-lab-ec2-high-cpu"
  alarm_description = "Triggers when EC2 average CPU utilization exceeds 20%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  period              = 300
  evaluation_periods  = 1
  threshold           = 20
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    InstanceId = aws_instance.lab.id
  }

  treat_missing_data = "missing"

  alarm_actions = [
    "arn:aws:sns:us-east-1:102378190347:AWS-billing-alerts"
  ]
}
