# Bootstrap Google Cloud Platform

1. Launch a Cloud Shell (<https://console.cloud.google.com>)

1. Create a project

    ```bash
    gcloud \
      projects \
      create \
      woffenden \
      --organization=805460595753 \
      --enable-cloud-apis \
      --set-as-default
    ```

1. Create KMS keyrings (`global` and `europe-west2`)

    ```bash
    gcloud \
      kms \
      keyrings \
      create \
      global-keyring \
      --location=global

    gcloud \
      kms \
      keyrings \
      create \
      europe-west2-keyring \
      --location=europe-west2
    ```

1. Create KMS keys (`global`, `europe-west2` and `terraform`)

    ```bash
    gcloud \
      kms \
      keys \
      create \
      global-key \
      --location=global \
      --keyring=global-keyring \
      --purpose=encryption \
      --default-algorithm=google-symmetric-encryption \
      --protection-level=software

    gcloud \
      kms \
      keys \
      create \
      europe-west2-key \
      --location=europe-west2 \
      --keyring=europe-west2-keyring \
      --purpose=encryption \
      --default-algorithm=google-symmetric-encryption \
      --protection-level=software

    gcloud \
      kms \
      keys \
      create \
      terraform-key \
      --location=europe-west2 \
      --keyring=europe-west2-keyring \
      --purpose=encryption \
      --default-algorithm=google-symmetric-encryption \
      --protection-level=software
    ```

1. Create Storage Bucket

    ```bash
    gsutil \
      kms \
      authorize \
      -k projects/woffenden/locations/europe-west2/keyRings/europe-west2-keyring/cryptoKeys/terraform-key

    gsutil \
      mb \
      -b on \
      -c nearline \
      -k projects/woffenden/locations/europe-west2/keyRings/europe-west2-keyring/cryptoKeys/terraform-key \
      -l europe-west2 \
      --pap enforced gs://iac.woffenden.io
    ```

1. Create Service Account

    ```bash
    gcloud \
      iam \
      service-accounts \
      create \
      github-actions \
      --display-name="GitHub Actions Service Account"
    ```

1. Assign Roles to Service Account

    ```bash
    gcloud \
      projects \
      add-iam-policy-binding \
      --member="serviceAccount:github-actions@woffenden.iam.gserviceaccount.com" \
      --role="roles/resourcemanager.organizationAdmin"

    gcloud \
      projects \
      add-iam-policy-binding \
      --member="serviceAccount:github-actions@woffenden.iam.gserviceaccount.com" \
      --role="roles/storage.admin"

    gcloud \
      projects \
      add-iam-policy-binding \
      --member="serviceAccount:github-actions@woffenden.iam.gserviceaccount.com" \
      --role="roles/compute.admin"
    ```

1. Configure Workload Identity

    ```bash
    gcloud \
      iam \
      workload-identity-pools \
      create \
      "github-actions" \
      --location="global" \
      --display-name="GitHub Actions"

    gcloud \
      iam \
      workload-identity-pools \
      providers \
      create-oidc \
      "github-actions" \
      --location="global" \
      --workload-identity-pool="github-actions" \
      --display-name="GitHub Actions" \
      --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" \
      --issuer-uri="https://token.actions.githubusercontent.com"


    gcloud \
      iam \
      service-accounts \
      add-iam-policy-binding \
      "github-actions@woffenden.iam.gserviceaccount.com" \
      --role="roles/iam.workloadIdentityUser" \
      --member="principalSet://iam.googleapis.com/projects/800000204119/locations/global/workloadIdentityPools/github-actions/attribute.repository/woffenden/infrastructure"
    ```
