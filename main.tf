#
# SNS
#

data "aws_sns_topic" "main" {
  name = var.sns_topic_name
}

#
# CloudWatch Event
#

resource "aws_cloudwatch_event_rule" "main" {
  name          = "rds-permission-events"
  description   = "AWS RDS events"
  event_pattern = file("${path.module}/event-pattern.json")
}

resource "aws_cloudwatch_event_target" "main" {
  rule      = aws_cloudwatch_event_rule.main.name
  target_id = "send-to-sns"
  arn       = data.aws_sns_topic.main.arn

  input_transformer {
    input_paths = {
      event      = "$.detail.eventName"
      parameters = "$.detail.requestParameters"
    }

    input_template = "\"AWS RDS Snapshot Change: Event <event> with request parameters: <parameters>.\""
  }
}
