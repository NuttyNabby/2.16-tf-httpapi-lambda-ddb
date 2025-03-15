data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", "${data.aws_caller_identity.current.arn}")[1]
}
# Get all CloudWatch Log Groups dynamically
data "aws_cloudwatch_log_groups" "all_logs" {}

# Extract account alias dynamically (for naming metric namespaces)
data "aws_iam_account_alias" "current" {}

locals {
  alias          = data.aws_iam_account_alias.current.account_alias # Define alias here
}
