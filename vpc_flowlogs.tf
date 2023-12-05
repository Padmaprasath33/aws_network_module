resource "aws_flow_log" "vpc_main_flowlogs" {
  iam_role_arn    = aws_iam_role.vpc_main_flowlog_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_main_flowlog_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

resource "aws_cloudwatch_log_group" "vpc_main_flowlog_group" {
  //name = var.vpc_main_flowlog_group_name
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
  name               = var.vpc_main_flowlog_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
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
  name   = var.vpc_main_flowlog_policy_name
  role   = aws_iam_role.vpc_main_flowlog_role.id
  policy = data.aws_iam_policy_document.vpc_main_flowlog_policy.json
}