#!/bin/bash

set -e

# if [[ "${GITHUB_EVENT_NAME}" == "pull_request" ]]; then
# 	EVENT_ACTION=$(jq -r ".action" "${GITHUB_EVENT_PATH}")
# 	if [[ "${EVENT_ACTION}" != "opened" ]]; then
# 		echo "No need to run analysis. It is already triggered by the push event."
# 		exit 78
# 	fi
# fi

if [[ -z "${INPUT_PASSWORD}" ]]; then
	SONAR_PASSWORD="&& true"
else
	SONAR_PASSWORD="${INPUT_PASSWORD}"
fi

[[ -n "${INPUT_LINTCOMMAND}" ]] || [[ -n "${INPUT_TESTCOMMAND}" ]] && npm install

[[ -n "${INPUT_CUSTOMCOMMAND}" ]] && ${INPUT_CUSTOMCOMMAND}

[[ -n "${INPUT_LINTCOMMAND}" ]] && ${INPUT_LINTCOMMAND}

[[ -n "${INPUT_TESTCOMMAND}" ]] && ${INPUT_TESTCOMMAND}

sonar-scanner \
	-Dsonar.projectKey=${GITHUB_REPOSITORY#*/} \
	-Dsonar.projectName=${GITHUB_REPOSITORY#*/} \
	-Dsonar.sources=. \
	-Dsonar.host.url=${INPUT_HOST} \
	-Dsonar.login=${INPUT_LOGIN} \
	-Dsonar.projectBaseDir=${INPUT_PROJECTBASEDIR} \
	-Dsonar.sourceEncoding=UTF-8

