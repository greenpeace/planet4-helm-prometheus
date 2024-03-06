[![Greenpeace](https://circleci.com/gh/greenpeace/planet4-helm-prometheus.svg?style=shield)](https://circleci.com/gh/greenpeace/planet4-helm-prometheus)

![Planet4](./p4logo.png)
# Kube Prometheus stack

A collection of Kubernetes manifests, Grafana dashboards, and Prometheus rules to operate end-to-end Kubernetes cluster monitoring with Prometheus using the Prometheus Operator.

<h1>Important Notes</h1>

>This deployment integrates with grafana.greenpeace.org, so please check this following a new deployment.

***
### Requirements - Internal Only
-   Access to P4 Infra [environment](https://www.notion.so/p4infra/bab9d0b1f2db4d929a59916899d531c1?v=eca7b78e1ae345c6883a9b37c6b76cac)

### Built with
- [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) helm chart

### Deployment
This repository is deployed via [CircleCI](https://circleci.com/gh/greenpeace/planet4-helm-prometheus)

 - Commits to the develop branch trigger deployment to the development cluster.  
 - Create a PR for review to prepare for production deployment.
 - Approval and merge deploys to production.

### Probes
The Blackbox Exporter Probes are deployed by each site as part of the `planet4-helm-wordpress` chart: https://github.com/greenpeace/planet4-helm-wordpress/blob/main/templates/probe.yaml  
They are only deployed during a site deployment, so if they are deleted, to redeploy the probes you will need to redeploy the site.  
**Deleting the Probe CRD will destroy all Probes.**  
A full re-release (all sites) can be trigged like this: https://github.com/greenpeace/planet4-base/commit/c9948dd017eb49acc73b40f19d238c907b34d51e  

### Usage
 - Access Grafana:
       [here for P4 dev](https://grafana.p4.greenpeace.org/?orgId=1)
       [here for P4 prod](https://prod.grafana.p4.greenpeace.org/?orgId=1)
       [here for IT Ops](https://grafana.greenpeace.org/)

 - Clone the repo to access makefile commands via cli that are not executed via CircleCI
   - `make status` - <em> display status of named release </em>
   - `make value` - <em> display user values followed by all values deployed </em>
   - `make history` - <em> display deployment history of named release </em>
   - `make port` - <em> expose port to local machine to access service </em>
   - `make uninstall` - <em> delete release while retaining history, CRDs, PVs etc.</em>
   - `make destroy` - <em> destroy release including CRDs, PVs etc. </em> <strong> CAUSES DATA LOSS </strong>

 ### Infra Documentation
 - External
   - [P4 Gitbook](https://support.greenpeace.org/planet4/infrastructure/intro)
 - Internal use only
   - [P4 Notion](https://www.notion.so/p4infra/)

 ### Contributing
 If your interested in contributing to P4 Infrastructure code please check our our community page [here](https://github.com/greenpeace/planet4).
