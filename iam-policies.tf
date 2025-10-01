 
// infra/terraform/policies/external-secrets-read.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecrets"
      ],
      "Resource": "arn:aws:secretsmanager:REGION:ACCOUNT_ID:secret:prod/myapp/*"
    }
  ]
}
 
 
