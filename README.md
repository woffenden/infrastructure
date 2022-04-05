# infrastructure

## Ansible

```bash
ansible-galaxy collection install --force --requirements-file collections/requirements.yaml
```

---

## Terraform

```bash
docker run -it --rm --volume $( pwd ):/workspace --workdir /workspace google/cloud-sdk:latest /bin/bash
gcloud auth activate-service-account --key-file=github-actions-service-account-key.json
```