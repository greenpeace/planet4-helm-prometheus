#!/usr/bin/env bash
set -euo pipefail

# CRDs created by this chart are not removed by default and should be manually
# cleaned up.  # https://artifacthub.io/packages/helm/prometheus-worawutchan/kube-prometheus-stack/10.3.2
# Kubernetes 1.15+
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
