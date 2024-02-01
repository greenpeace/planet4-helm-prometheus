#!/usr/bin/env bash
set -euo pipefail

kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_prometheusagents.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_scrapeconfigs.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl replace -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.67.1/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
