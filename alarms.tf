# Create an SNS Topic for alerts
resource "aws_sns_topic" "alert_topic" {
  name = "${local.alias}-alert-topic"  # Use the alias dynamically from the caller identity
}

# Create an SNS Subscription (example email subscription)
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = "nabilah.tang@gmail.com"  # Replace with your actual email
}

# Accept the subscription (use `aws sns` CLI command or manual action)
resource "null_resource" "accept_sns_subscription" {
  depends_on = [aws_sns_topic_subscription.email_subscription]

  provisioner "local-exec" {
    command = "echo 'Please check your email to confirm subscription to SNS alerts.'"
  }
}
