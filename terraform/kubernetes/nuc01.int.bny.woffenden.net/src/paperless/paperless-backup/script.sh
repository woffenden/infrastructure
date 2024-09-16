#!/usr/bin/env sh

#
# IT IS ESSENTIAL THAT THIS DEPLOYMENT HAS THE PVCS MAPPED TO THE SAME LOCATION
#

readonly _RUNTIME_ISO8601
_RUNTIME_ISO8601="$(date -I'seconds')"

############################# Install Tools

apk add --update --quiet \
  curl \
  jq \
  rclone

curl --silent --location https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl --output /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

############################# Script

for deployment in paperless postgres; do
  echo "Processing Deployment: ${deployment}"

  # Scale down deployment
  kubectl --namespace "${KUBERNETES_NAMESPACE}" scale deployment/${deployment} --replicas=0

  # Wait for it to go down down down
  while true; do
    if [ "$(kubectl --namespace "${KUBERNETES_NAMESPACE}" get deployment/${deployment} --output json | jq -r '.status.replicas')" != "1" ]; then
      echo "Deployment has 0 replicas, waiting 10 seconds just incase things need to clean up"
      sleep 10
      break
    else
      echo "Deployment still active, waiting..."
      sleep 2
    fi
  done

  # Process volume mounts
  for volumeMount in $(kubectl --namespace "${KUBERNETES_NAMESPACE}" get deployment/${deployment} --output json | jq -r --arg CONTAINER_NAME "${deployment}" '.spec.template.spec.containers[] | select( .name==$CONTAINER_NAME ) | .volumeMounts[].mountPath'); do
    echo "  Processing volume mount: ${volumeMount}"

    volumeMountShort=$(basename "${volumeMount}")
    export volumeMountShort
    export archiveName="${deployment}-${volumeMountShort}"

    tar -zcvf "/tmp/${archiveName}.tar.gz" "${volumeMount}"

    rclone copy "/tmp/${archiveName}.tar.gz" "${RCLONE_FS}/backups/${_RUNTIME_ISO8601}/"
  done

done

for deployment in postgres paperless; do
  # Scale up
  kubectl --namespace "${KUBERNETES_NAMESPACE}" scale deployment/${deployment} --replicas=1

  # Wait for it to be up
  kubectl --namespace "${KUBERNETES_NAMESPACE}" wait pods -l app=${deployment} --for condition=Ready --timeout=120s

  # Pause for a little bit
  sleep 60
done
