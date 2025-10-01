#!/usr/bin/env bash
set -euo pipefail
 
# Example bootstrap script that calls terraform and sets up kubeconfig
cd infra/terraform
terraform init
terraform apply -auto-approve
 
# configure kubectl
aws eks update-kubeconfig --region ${AWS_REGION:-us-east-1} --name $(terraform output -raw cluster_name)
 
# install ALB controller, external-secrets, gatekeeper, prometheus stack, fluent-bit via helm
# placeholder commands - customize per environment
 
