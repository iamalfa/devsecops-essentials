
# DevSecOps Practice & Container Hardening

![DevSecOps CI](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml/badge.svg)

A hands-on repository demonstrating core automation scripting, hardened container architecture, and security scanning.

## Repository Structure

- **bash-automation/**
  - `sys_monitor.sh`: System health (RAM, disk, uptime) check
  - `service_checker.sh`: Dynamic service validator with exit codes
  - `multi_check.sh`: Automated multi-service auditor
  - `log_analyzer.sh`: SSH brute-force threat detection using awk/grep
- **my-custom-app/**
  - `Dockerfile`: Security-hardened non-root unprivileged Nginx image
  - `docker-compose.yml`: Multi-tier stack with isolated private bridge network
  - `index.html`: Custom web portal template

## Key Security Implementations
- **Non-Root Execution:** Hardened container user context to unprivileged `nginx` user (preventing container breakout risks).
- **Vulnerability Scanning:** Audited via Aquasec Trivy (0 High/Critical vulnerabilities).
- **Network Isolation:** Redis database isolated from public exposure using internal Docker bridge networks.
