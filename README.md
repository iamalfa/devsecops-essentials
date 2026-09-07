# Enterprise DevSecOps CI/CD Pipeline & Observability Stack

[![DevSecOps CI/CD Pipeline](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml/badge.svg)](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml)
[![Docker Image](https://img.shields.io/badge/Registry-GHCR-blue?logo=github)](https://github.com/iamalfa/devsecops-essentials/pkgs/container/devsecops-custom-app)
[![Security Gates](https://img.shields.io/badge/Security-Shift--Left-green?logo=shield)](https://github.com/iamalfa/devsecops-essentials)
[![Observability](https://img.shields.io/badge/Telemetry-Prometheus%20%7C%20Grafana-orange?logo=grafana)](https://github.com/iamalfa/devsecops-essentials)

A production-grade DevSecOps pipeline and runtime observability architecture demonstrating automated Shift-Left security governance, vulnerability scanning, automated artifact release, and full-stack system telemetry.

---

### End-to-End Pipeline & Telemetry Flow

1. **Commit & Static Security Audit (SAST)**
   * **Gitleaks:** Scans git commits and history for hardcoded secrets and credentials.
   * **ShellCheck:** Lints Bash automation scripts for POSIX compliance and shell execution safety.
   * **Semgrep:** Enforces fast static application security rules (zero error bypass).

2. **Container Security & Vulnerability Gate**
   * **Trivy (IaC & Config):** Validates Dockerfile misconfigurations and security baselines.
   * **Hardened Docker Build:** Multi-stage build producing an unprivileged Alpine container (Port 8080).
   * **Trivy (Image Scan):** Enforces automated build failure on CRITICAL CVEs.
   * **GHCR Publishing:** Automates release to GitHub Container Registry upon passing checks.

3. **Runtime Staging & Verification**
   * **Staging Deployment:** Deploys ephemeral container directly from GHCR.
   * **Automated Smoke Test:** Runs health probe verifying `200 OK` status before pipeline success.
   * **Teardown:** Clean automated teardown of staging test instances.

4. **Runtime Telemetry & Observability**
   * **Prometheus:** Time-series metric collection engine scraping target endpoints.
   * **Node Exporter:** Real-time host metrics extraction (CPU, Memory, Disk, Network).
   * **Blackbox Exporter:** Synthetic HTTP health probe verifying web-app availability (`probe_success`).
   * **Grafana:** Visual dashboards for live metric analytics and infrastructure health tracking.

---

### Security Gates & Tooling Matrix

| Stage | Security Control | Tool | Purpose / Policy Enforced |
| :--- | :--- | :--- | :--- |
| Commit Audit | Secret Leak Detection | Gitleaks | Blocks exposed API keys, private certs, and credentials. |
| Linting | Script Reliability | ShellCheck | Enforces safe quoting and POSIX standards on shell automation. |
| SAST | Static Analysis | Semgrep | Scans application code for dangerous patterns and insecure primitives. |
| IaC Hardening | Config Audit | Trivy (Config) | Audits Dockerfile instructions and baseline container security. |
| Vulnerability | Container Scanning | Trivy (Image) | Blocks artifact release on discovered CRITICAL CVEs. |
| Delivery | Artifact Security | GHCR | Secure immutable container registry hosting release images. |
| Staging Test | Smoke Probe | Curl / Docker | Validates non-root listener health in isolated staging. |
| Telemetry | Metrics & Health | Prometheus / Grafana | Real-time synthetic uptime probes and system metric dashboards. |

---

### Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── devsecops-ci.yml      # 3-Stage CI/CD GitHub Actions Pipeline
├── bash-automation/
│   ├── log_analyzer.sh           # SSH brute-force & log analysis utility
│   └── system_health.sh          # Server performance & threshold monitor
├── monitoring/
│   └── prometheus/
│       └── prometheus.yml        # Telemetry & blackbox probe configurations
├── my-custom-app/
│   ├── Dockerfile                # Hardened non-root unprivileged container
│   └── index.html                # Lightweight web asset
├── docker-compose.yml            # Multi-container observability stack
└── README.md                     # Technical architecture documentation
```

### Quick Start (Local Deployment)

Clone the repository and spin up the complete application and observability stack:

```bash
# Clone the repository
git clone https://github.com/iamalfa/devsecops-essentials.git
cd devsecops-essentials

# Launch complete stack (Web App, Prometheus, Exporters, Grafana)
docker compose up -d

# Verify running containers
docker ps


Access Endpoints:

    Web Application: http://localhost:8080

    Prometheus UI: http://localhost:9090

    Grafana Dashboards: http://localhost:3000 (User: admin | Pass: admin)

    Node Exporter Metrics: http://localhost:9100/metrics

    Blackbox Exporter: http://localhost:9115
