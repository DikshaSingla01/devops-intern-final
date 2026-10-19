#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="${1:-http://localhost:8080/healthz}"

echo "Checking health target: ${TARGET_URL}"

if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl is required but not installed." >&2
    exit 1
fi

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 --max-time 10 "${TARGET_URL}" || true)

if [ "${HTTP_CODE}" = "200" ]; then
    echo "SUCCESS: Endpoint ${TARGET_URL} returned HTTP 200 OK."
    exit 0
else
    echo "FAILURE: Endpoint ${TARGET_URL} returned HTTP ${HTTP_CODE} (expected 200)." >&2
    exit 1
fi
