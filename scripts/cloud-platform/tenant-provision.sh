#!/usr/bin/env bash

ENVIRONMENT_CONFIGURATION_DIRECTORY="terraform/aws/root/organisation/configuration/cloud-platform-environments"
CLOUD_PLATFORM_TENANT_DIRECTORY="terraform/aws/cloud-platform-tenants"

cloudPlatformTenants=$(ls terraform/aws/root/organisation/configuration/cloud-platform-environments | sed 's/.json//')
export cloudPlatformTenants

for tenant in ${cloudPlatformTenants}; do
  tenantApplication=$(jq -r ".tags.application" "${ENVIRONMENT_CONFIGURATION_DIRECTORY}/${tenant}.json")
  export tenantApplication
  tenantBusinessUnit=$(jq -r ".tags.business_unit" "${ENVIRONMENT_CONFIGURATION_DIRECTORY}/${tenant}.json")
  export tenantBusinessUnit
  tenantOwner=$(jq -r ".tags.owner" "${ENVIRONMENT_CONFIGURATION_DIRECTORY}/${tenant}.json")
  export tenantOwner

  echo "Processing tenant: ${tenant}"
  if [[ ! -d "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}" ]]; then
    echo " -> Tenant directory does not exist, creating: ${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}"
    mkdir --parents "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}"
  else
    echo " -> Tenant directory already exists"
  fi

  echo " -> Copying tenant configuration to: ${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}/_cloud-platform-terraform.tf"
  cp scripts/cloud-platform/src/_cloud-platform-terraform.tf.tpl "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}/_cloud-platform-terraform.tf"

  echo " -> Processing tenant configuration: ${ENVIRONMENT_CONFIGURATION_DIRECTORY}/${tenant}.json"
  sed -i "s/TENANT_NAME/${tenant}/g" "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}/_cloud-platform-terraform.tf"
  sed -i "s/APPLICATION/${tenantApplication}/g" "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}/_cloud-platform-terraform.tf"
  sed -i "s/BUSINESS_UNIT/${tenantBusinessUnit}/g" "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}/_cloud-platform-terraform.tf"
  sed -i "s/OWNER/${tenantOwner}/g" "${CLOUD_PLATFORM_TENANT_DIRECTORY}/${tenant}/_cloud-platform-terraform.tf"
done
