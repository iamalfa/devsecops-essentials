# Enterprise DevSecOps CI/CD Pipeline & Automated Security Governance

[![DevSecOps CI/CD Pipeline](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml/badge.svg)](https://github.com/iamalfa/devsecops-essentials/actions/workflows/devsecops-ci.yml)
[![Docker Image](https://img.shields.io/badge/Registry-GHCR-blue?logo=github)](https://github.com/iamalfa/devsecops-essentials/pkgs/container/devsecops-custom-app)
[![Security Gates](https://img.shields.io/badge/Security-Shift--Left-green?logo=shield)](https://github.com/iamalfa/devsecops-essentials)

A production-grade, end-to-end DevSecOps pipeline demonstrating automated Shift-Left security controls, static analysis, vulnerability scanning, continuous delivery, and runtime staging verification.

---

### Pipeline Workflow

1. **Commit & Static Security Audit (SAST)**
   * **Gitleaks:** Scans git history and commits for secrets, tokens, and credentials.
   * **ShellCheck:** Lints Bash automation scripts for shell safety and best practices.
   * **Semgrep:** Fast static analysis scanning for misconfigurations and vulnerabilities.

2. **Container Security & Vulnerability Gate**
   * **Trivy (IaC & Config):** Validates Dockerfile security baselines.
   * **Hardened Docker Build:** Builds unprivileged Alpine container (Port 8080).
   * **Trivy (Image Scan):** Enforces security gating by failing pipeline on CRITICAL CVEs.
   * **GHCR Publishing:** Automated release to GitHub Container Registry upon passing gates.

3. **Runtime Staging & Verification**
   * **Staging Deployment:** Ephemeral deployment pulling verified artifact from GHCR.
   * **Automated Smoke Test:** Health probe executing HTTP status checks (200 OK).
   * **Teardown:** Clean automated teardown of staging resources.

---

### Security Gates & Tooling Matrix

| Stage | Security Control | Tool | Purpose / Policy Enforced |
| :--- | :--- | :--- | :--- |
| Commit Audit | Secret Leak Detection | Gitleaks | Blocks exposed API tokens, private keys, and environment variables. |
| Linting | Script Reliability | ShellCheck | Enforces POSIX compliance, quoting, and safe Bash execution patterns. |
| SAST | Static Analysis | Semgrep | Scans application files for dangerous patterns and insecure primitives. |
| IaC Hardening | Config Audit | Trivy (Config) | Verifies baseline Dockerfile and deployment configurations. |
| Vulnerability | Container Scanning | Trivy (Image) | Gates container promotion by failing pipeline on CRITICAL CVEs. |
| Delivery | Artifact Security | GHCR | Immutable container publishing tied to commit SHA and latest tag. |
| Runtime | Smoke & Health Probe | Curl / Docker | Validates non-root listener health (Port 8080) in isolated staging. |

---

### Container Hardening Highlights

* **Unprivileged Execution:** Runs under unprivileged user context (`UID 101`) rather than `root`, preventing container escape.
* **Minimal Base Distro:** Implemented on Alpine Linux base to minimize attack surface.
* **Port Isolation:** High-numbered port binding (`8080`) complying with non-root security standards.
* **Automated Patching:** Layered package upgrades applied during image build to resolve base image vulnerabilities.

---

### Repository Structure
```text
.
├── .github/
│   └── workflows/
│       └── devsecops-ci.yml
├── bash-automation/
│   ├── log_analyzer.sh
│   └── system_health.sh
├── my-custom-app/
│   ├── Dockerfile
│   └── index.html
└── README.md
```

Quick Start (Local Run)

Pull and run the verified hardened container directly from the registry:

docker pull ghcr.io/iamalfa/devsecops-custom-app:latest

docker run -d --name devsecops-app -p 8080:8080 ghcr.io/iamalfa/devsecops-custom-app:latest

curl -I http://localhost:8080
