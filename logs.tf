# Create CloudWatch Logs Insights Query Definition
resource "aws_cloudwatch_query_definition" "log_query" {
  name            = "${local.name_prefix}-query"
  log_group_names = data.aws_cloudwatch_log_groups.all_logs.log_group_names

  query_string = <<EOT
fields @timestamp, @message, @logStream, @log
| sort @timestamp desc
| limit 10000
EOT
}
