# Log into Google Cloud

```bash
gcloud auth login
```

---

# Create Google Cloud Project

```bash
gcloud projects create \
  woffenden \
  --organization=805460595753 \
  --enable-cloud-apis \
  --set-as-default
```

---

# Create KMS Keyrings

## Global

```bash
gcloud kms keyrings create global-keyring --location=global
```

## Regional (europe-west2)

```bash
gcloud kms keyrings create europe-west2-keyring --location=europe-west2
```

---

# Create KMS Keys

## Global

```bash
gcloud kms keys create global-key --location=global --keyring=global-keyring --purpose=encryption --default-algorithm=google-symmetric-encryption --protection-level=software
```

## Regional (europe-west2)

```bash
gcloud kms keys create europe-west2-key --location=europe-west2 --keyring=europe-west2-keyring --purpose=encryption --default-algorithm=google-symmetric-encryption --protection-level=software
```

```bash
gcloud kms keys create terraform-key --location=europe-west2 --keyring=europe-west2-keyring --purpose=encryption --default-algorithm=google-symmetric-encryption --protection-level=software
```

---

# Create Storage Bucket

```bash
gsutil kms authorize -k projects/woffenden/locations/europe-west2/keyRings/europe-west2-keyring/cryptoKeys/terraform-key
```

```bash
gsutil mb -b on -c nearline -k projects/woffenden/locations/europe-west2/keyRings/europe-west2-keyring/cryptoKeys/terraform-key -l europe-west2 --pap enforced gs://iac.woffenden.io
```

---

# Create Service Account

```bash
gcloud iam service-accounts create \
  github-actions \
  --display-name="GitHub Actions Service Account"
```

# Assign Roles

```bash
gcloud projects add-iam-policy-binding woffenden \
    --member="serviceAccount:github-actions@woffenden.iam.gserviceaccount.com" \
    --role="roles/resourcemanager.organizationAdmin"

gcloud projects add-iam-policy-binding woffenden \
    --member="serviceAccount:github-actions@woffenden.iam.gserviceaccount.com" \
    --role="roles/storage.admin"

gcloud projects add-iam-policy-binding woffenden \
    --member="serviceAccount:github-actions@woffenden.iam.gserviceaccount.com" \
    --role="roles/compute.admin"
```

# Configure Workload Identity

```bash
gcloud \
  iam \
  workload-identity-pools \
  create \
  "github-actions" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions"

gcloud \
  iam \
  workload-identity-pools \
  providers \
  create-oidc \
  "github-actions" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="github-actions" \
  --display-name="GitHub Actions" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"


gcloud \
  iam \
  service-accounts \
  add-iam-policy-binding \
  "github-actions@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/800000204119/locations/global/workloadIdentityPools/github-actions/attribute.repository/woffenden/infrastructure"
```
