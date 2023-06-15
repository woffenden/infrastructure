# Bootstrap AWS Root Account

1. Log into AWS Root Account using Root user credentials

1. Enable MFA on Root user credentials

1. Generate an Access Keypair (<https://console.aws.amazon.com/iam/home#/security_credentials>)

1. Launch an AWS CLI Container

    ```bash
    export AWS_ACCESS_KEY_ID="< Access Key ID from step 3 >"
    export AWS_SECRET_ACCESS_KEY="< Secret Access Key from step 3 >"
    docker \
      run \
      -it \
      --rm \
      --entrypoint /bin/bash \
      --env AWS_DEFAULT_REGION="eu-west-2" \
      --env AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
      --env AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
      --volume $( pwd ):/workspace \
      --workdir /workspace \
      docker.io/amazon/aws-cli
    ```

1. Validate AWS Identity

    ```bash
    aws sts get-caller-identity
    {
        "UserId": "769520176253",
        "Account": "769520176253",
        "Arn": "arn:aws:iam::769520176253:root"
    }
    ```

1. Create CloudFormation Stack

    ```bash
    aws \
      cloudformation \
      create-stack \
      --stack-name root-account-bootstrap \
      --template-body file://cloudformation/root-account-bootstrap.yaml \
      --capabilities CAPABILITY_NAMED_IAM
    ```

1. Delete Root Access Keypair (<https://console.aws.amazon.com/iam/home#/security_credentials>)

## Updating

In case you need to perform an update to the root-account-bootstrap, repeat steps 1 to 5 and then

```bash
aws \
  cloudformation \
  update-stack \
  --stack-name root-account-bootstrap \
  --template-body file://cloudformation/root-account-bootstrap.yaml \
  --capabilities CAPABILITY_NAMED_IAM
```
