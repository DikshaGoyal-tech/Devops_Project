This repository contains a security-first reference implementation for building, scanning, and deploying a Node.js application to AWS EKS.
 
**Features included**:
- Multi-stage, non-root Dockerfile
- GitHub Actions pipeline with Trivy image scan (fail on CRITICAL)
- Terraform to provision EKS cluster (module-based)
- Kubernetes manifests: Node app (Deployment), MongoDB (StatefulSet), Service, Ingress (AWS ALB), NetworkPolicy
- Gatekeeper policy for non-root enforcement
- Prometheus alert rule example
- Fluent Bit config with log color mapping Lua script
- Argo Rollouts example for Canary deployments
 
**How to use**
1. Replace placeholders (ARNs, ACCOUNT_ID, REGISTRY names, region) in files.
2. Provision infra: terraform init/plan/apply in `/terraform`.
3. Build & push images through GitHub Actions.
4. Deploy k8s manifests in `k8s/` to your cluster.
5. Install supporting controllers via Helm: ALB Controller, ExternalSecrets, Gatekeeper, Prometheus, Fluent Bit, Argo Rollouts, Falco.
 
**Security notes**
- Use OIDC for CI to authenticate to cloud providers.
- Use external secrets (AWS Secrets Manager or Vault) with IRSA.
- Enforce Pod Security Admission and Gatekeeper constraints.
- Run Trivy and store scan artifacts for compliance.
