# Enterprise DevSecOps CI/CD Pipeline & Automated Security Governance

[![DevSecOps CI/CD Pipeline](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml/badge.svg)](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml)
[![Docker Image](https://img.shields.io/badge/Registry-GHCR-blue?logo=github)](https://github.com/iamalfa/devsecops-essentials/pkgs/container/devsecops-custom-app)
[![Security Gates](https://img.shields.io/badge/Security-Shift--Left-green?logo=shield)](https://github.com/iamalfa/devsecops-essentials)

A production-grade, end-to-end DevSecOps pipeline demonstrating automated Shift-Left security controls, static analysis, vulnerability scanning, continuous delivery, and runtime staging verification.

---

## Architecture Overview

[ Developer Push ]
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│ 1. Static Security & SAST Audit                             │
│    ├── Gitleaks     : Hardcoded Secret & Token Detection    │
│    ├── ShellCheck   : Static Shell Script Quality & Linting │
│    └── Semgrep      : SAST Rule Enforcement (Zero Bypass)   │
└──────────────────────────────┬──────────────────────────────┘
                               │ (Pass)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Container Hardening & CVE Audit                          │
│    ├── Trivy Config : IaC & Dockerfile Hardening Checks     │
│    ├── Docker Build : Multi-tier Non-Root Container         │
│    ├── Trivy Image  : OS/Lib Vulnerability Scan (CRITICAL=1)│
│    └── GHCR Push    : Publish Scanned Container Image       │
└──────────────────────────────┬──────────────────────────────┘
                               │ (Pass)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Automated Staging Smoke Testing                          │
│    ├── Pull Image   : Fetch verified package from GHCR      │
│    ├── Spin Up      : Run unprivileged container (:8080)    │
│    ├── Health Probe : Automated HTTP curl status code check │
│    └── Tear Down    : Ephemeral environment cleanup         │
└─────────────────────────────────────────────────────────────┘


Container Hardening Highlights

    Unprivileged Execution: Runs under custom unprivileged user context (UID 101) rather than root, mitigating container breakout risks.

    Minimal Base Distro: Implemented on Alpine Linux base to minimize attack surface and reduce package dependencies.

    Port Restriction: High-numbered port binding (8080) to comply with non-root Linux networking restrictions.

    Automated Upgrades: Built-in package patching layer to mitigate discovered base image CVEs during image creation.


Repository Structure

├── .github/
│   └── workflows/
│       └── devsecops-ci.yml      # Multi-stage CI/CD workflow
├── bash-automation/
│   ├── log_analyzer.sh           # System auth log & brute-force parser
│   └── system_health.sh          # System metrics monitor (CPU, RAM, Disk)
├── my-custom-app/
│   ├── Dockerfile                # Hardened, non-root Nginx setup
│   └── index.html                # Deployed lightweight web asset
└── README.md                     # Technical architecture documentation


Quick Start (Local Run)

To run the hardened, pipeline-verified container locally from the registry:

# Pull image from GitHub Container Registry
docker pull ghcr.io/iamalfa/devsecops-custom-app:latest

# Run on unprivileged port 8080
docker run -d --name devsecops-app -p 8080:8080 ghcr.io/iamalfa/devsecops-custom-app:latest

# Test endpoint health
curl -I http://localhost:8080
