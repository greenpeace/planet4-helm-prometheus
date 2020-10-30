# Planet-4 Helm chart kube-prometheus-stack deployment

## Ingredients:
-   helm client [https://docs.helm.sh/using_helm/](https://docs.helm.sh/using_helm/)
-   an accessible Kubernetes cluster running Helm Tiller

## Important Notes:

***
NOT currently deployed to the production cluster.  kube-state-metrics and NewRelic in use in production.

CRDs manually deployed in Dev

***

## Preparation:

This repository is intended to be used via [CircleCI](https://circleci.com/gh/greenpeace/planet4-traefik)

Commits to the develop branch affect the development cluster.  When ready to deploy, use master to deploy to prod.

---
