#!/usr/bin/env bash

set -e

if [ -z "$GITHUB_URL" ]; then
    echo "GITHUB_URL is required"
    exit 1
fi

RUNNER_NAME="${RUNNER_NAME:-docker-actions-runner}"
RUNNER_LABELS="${RUNNER_LABELS:-local-service}"

# the token is only needed for first-time registration
if [ ! -f ".runner" ]; then
    if [ -z "$RUNNER_TOKEN" ]; then
        echo "RUNNER_TOKEN is required"
        exit 1
    fi
    ./config.sh \
        --unattended \
        --url "$GITHUB_URL" \
        --token "$RUNNER_TOKEN" \
        --name "$RUNNER_NAME" \
        --labels "$RUNNER_LABELS" \
        --work "_work" \
        --replace
fi

exec ./run.sh

