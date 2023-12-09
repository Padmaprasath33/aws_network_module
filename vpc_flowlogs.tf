resource "aws_flow_log" "vpc_main_flowlogs" {
  iam_role_arn    = aws_iam_role.vpc_main_flowlog_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_main_flowlog_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  tags = var.resource_tags
}

resource "aws_cloudwatch_log_group" "vpc_main_flowlog_group" {
  name = "2191420-cohort-vpc-flowlog-group"
  tags = var.resource_tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_main_flowlog_role" {
  name               = "2191420-vpc-main-flowlog-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = var.resource_tags
}

data "aws_iam_policy_document" "vpc_main_flowlog_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "vpc_main_flowlogs" {
  name   = "2191420-vpc-main-flowlog-policy"
  role   = aws_iam_role.vpc_main_flowlog_role.id
  policy = data.aws_iam_policy_document.vpc_main_flowlog_policy.json
}