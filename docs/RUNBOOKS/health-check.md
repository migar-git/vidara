---
prd-version: "1.0"
severity: "P1"
last-tested: "2026-04-27"
---

# Runbook: Service Health Check

## Symptoms
Service not responding, health endpoint returning errors.

## Diagnosis
1. Check service logs
2. Verify dependencies are running
3. Check resource utilization

## Remediation
1. Restart service
2. Check configuration
3. Verify network connectivity

## Escalation
P0: Service down in production - immediate response required.
