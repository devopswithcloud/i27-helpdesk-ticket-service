#!/usr/bin/env bash
# Creates/updates the i27-ticket-env Secret from .env.dev and rolls the deployment.
# Run from the i27-helpdesk-ticket-service directory:
#   bash k8s/secrets.sh

set -euo pipefail

kubectl create secret generic i27-ticket-env \
  --from-env-file=.env.dev \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl rollout restart deployment/i27-ticket 2>/dev/null || true
