locals {
  metric_ns      = "/moviedb-api/${local.alias}" # <-- Missing closing quote fixed
  metric_name    = "info-count"
  filter_pattern = "[INFO]"  # Matches logs containing "[INFO]"
}

# Create Metric Filters for each log group
resource "aws_cloudwatch_log_metric_filter" "info_count" { # <-- Name was cut off, fixed
  for_each = toset(data.aws_cloudwatch_log_groups.all_logs.log_group_names)

  name           = local.metric_name
  log_group_name = each.value
  pattern        = local.filter_pattern

  metric_transformation {
    name      = local.metric_name
    namespace = local.metric_ns
    value     = "1"
    unit      = "None"
  }
}
# Create a CloudWatch metric that sums the count on a 1-minute interval
resource "aws_cloudwatch_metric_alarm" "info_count_breach" {
  alarm_name                = "${local.alias}-info-count-breach"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = local.metric_name
  namespace                 = local.metric_ns
  period                    = 60  # 1-minute interval
  statistic                 = "Sum"  # Sum over 1 minute
  threshold                 = 10
  alarm_description         = "Triggered when info count exceeds 10 in 1 minute"
  insufficient_data_actions = []
  actions_enabled           = true

  # Send notification to SNS topic when alarm state changes
  alarm_actions = [aws_sns_topic.alert_topic.arn]
}




















