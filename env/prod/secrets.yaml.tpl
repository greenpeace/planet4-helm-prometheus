---
kind: Secret
apiVersion: v1
metadata:
  name: thanos-tls
  namespace: kube-system
  labels:
    app: fgt-prometheus-prod
type: kubernetes.io/tls
data:
  ca.crt: >-
    ${PROD_THANOS_CA}
  cacerts.pem: >-
    ${PROD_THANOS_CHAIN}
  tls.crt: >-
    ${PROD_THANOS_CRT}
  tls.key: >-
    ${PROD_THANOS_KEY}
---

---
kind: Secret
apiVersion: v1
metadata:
  name: thanos-key
  namespace: kube-system
data:
  objstore.yml: |
    type: GCS
    config:
      bucket: thanos-global-prod-psu2yupeuq
      service_account: |
        ${PROD_THANOS_GOOGLE_SERVICE_ACCOUNT}
type: Opaque
---