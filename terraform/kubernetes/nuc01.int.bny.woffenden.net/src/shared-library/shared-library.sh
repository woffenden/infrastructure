#!/usr/bin/env bash

####################################################################################################
# Name: Date ISO8601
# Description: Returns ISO8601 formatted date and time
# Usage: date_iso8601 "date|hours|minutes|seconds"
# Required Softwares: N/A
# Required Variables: N/A
####################################################################################################
date_iso8601() {
  local format="${1:-seconds}"

  echo "$(date -I${format})"
}

####################################################################################################
# Name: Logger
# Description: Standard logging message format
# Usage: logger "SEVERITY" "Example Log"
# Required Softwares: N/A
# Required Variables: N/A
####################################################################################################
logger() {
  local severity="${1}"

  local messageData="${2}"

  case ${severity} in
    info|INFO )
      local SEVERITY="INFO"
    ;;
    warn|WARN )
      local SEVERITY="WARN"
    ;;
    error|ERROR )
      local SEVERITY="ERROR"
    ;;
    debug|DEBUG )
      local SEVERITY="TRACE"
    ;;
    trace|TRACE )
      local SEVERITY="INFO"
    ;;
    * )
      echo "[$(date_iso8601)] [ERROR] Incorrect usage of logger(), please refer to shared-library.sh"
      return 1
    ;;
  esac

  echo "[$(date_iso8601)] [${SEVERITY}] ${messageData}"
}

####################################################################################################
# Name: External IP
# Description: Print current external IP address
# Usage: get_external_ip
# Required Softwares: curl, jq
# Required Variables: N/A
####################################################################################################
get_external_ip() {
  echo "$(curl --silent https://cloudflare.com/cdn-cgi/trace | grep "ip" | sed 's|ip=||')"
}

####################################################################################################
# Name: Slack Message
# Description: Send a Slack message using the new bot API
# Usage: slack_message "Example Message"
# Required Softwares: curl, jq
# Required Variables: SLACK_APP_TOKEN, SLACK_CHANNEL
####################################################################################################
slack_message() {
  local messageData="${1}"

  local postMessage=$(curl \
    --silent \
    --request POST \
    --header "Authorization: Bearer ${SLACK_APP_TOKEN}" \
    --data "channel=${SLACK_CHANNEL}" \
    --data "text=${messageData}" \
    https://slack.com/api/chat.postMessage )

  local postMessageOk=$( echo "${postMessage}" | jq -r '.ok')

  if [[ "${postMessageOk}" == "true" ]]; then
    local postMessageTs=$(echo "${postMessage}" | jq -r '.ts')
    logger "INFO" "Slack message sent! (TS: ${postMessageTs})"
  elif [[ "${postMessageOk}" == "false" ]]; then
    local postMessageError=$(echo "${postMessage}" | jq -r '.error')
    logger "ERROR" "Slack message failed to send! (Error: ${postMessageError})"
    return 1
  fi
}
