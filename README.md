Enables notifications to an SNS topic when a RDS snapshot is copied or shared with another account.

Creates the following resources:

* CloudWatch event rule to filter AWS RDS changes (CopyDBSnapshot, CopyDBClusterSnapshot, ModifyDBSnapshot, ModifyDBSnapshotAttribute)
* CloudWatch event target to send to SNS topic formatted as `AWS RDS Change: <title>`

## Usage

```hcl
module "rds-notifications" {
  source  = "trussworks/rds-notifications/aws"
  version = "1.0.0"

  sns_topic_name = "slack-events"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sns\_topic\_name | The name of the SNS topic to send AWS RDS notifications. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
