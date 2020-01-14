/**
 * Enables notifications to an SNS topic when a RDS snapshot is copied or shared with another account.
 *
 * Creates the following resources:
 *
 * * CloudWatch event rule to filter AWS RDS changes (CopyDBSnapshot, CopyDBClusterSnapshot, ModifyDBSnapshot, ModifyDBSnapshotAttribute)
 * * CloudWatch event target to send to SNS topic formatted as `AWS RDS Change: <title>`
 *
 * ## Usage
 *
 * ```hcl
 * module "rds-notifications" {
 *   source  = "trussworks/rds-notifications/aws"
 *   version = "1.0.0"
 *
 *   sns_topic_name = "slack-events"
 * }
 * ```
 */

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

