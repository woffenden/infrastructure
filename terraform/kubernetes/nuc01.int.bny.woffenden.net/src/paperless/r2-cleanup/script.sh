#!/usr/bin/env bash

BACKUP_RETENTION_DAYS="7"

backupRetentionEpoch=$(date --date "${BACKUP_RETENTION_DAYS} days ago" +"%s")

for backup in $(aws --endpoint-url "${AWS_ENDPOINT_URL}" s3 ls "s3://${CLOUDFLARE_R2_BUCKET}/backups/" | awk '{ print $2 }'); do

  backup=${backup//\//} # strip of trailing slash

  echo "Processing backup [ ${backup} ]"

  backupEpoch=$(date --date "${backup}" +"%s")

  if [[ "${backupEpoch}" -lt "${backupRetentionEpoch}" ]]; then

    echo "--> Backup [ ${backup} ] is older than cutoff, deleting."

    aws --endpoint-url "${AWS_ENDPOINT_URL}" s3 rm "s3://${CLOUDFLARE_R2_BUCKET}/backups/${backup}/" --recursive

  else

    echo "--> Backup [ ${backup} ] is newer than cutoff, preserving."

  fi

done
