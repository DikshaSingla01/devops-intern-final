#!/usr/bin/env bash
set -euo pipefail

echo "================ SYSTEM INFORMATION ================"
echo "User: $(id -un) (Effective UID: $(id -u))"
echo "Hostname: $(hostname)"
echo "Kernel Release: $(uname -r)"
echo "System Date (ISO-8601): $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo ""
echo "--- Disk Usage ---"
df -h
echo ""
echo "--- Memory Usage ---"
if command -v free >/dev/null 2>&1; then
    free -m
else
    echo "free utility not present on host environment"
fi
echo ""
echo "--- Docker Daemon Status ---"
if command -v docker >/dev/null 2>&1; then
    if docker info >/dev/null 2>&1; then
        echo "Docker daemon is running and responsive."
    else
        echo "Docker command found, but daemon is not responding or unreachable."
    fi
else
    echo "Docker CLI is not installed or not in PATH."
fi
echo "====================================================="
