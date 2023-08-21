---
kind: Secret
apiVersion: v1
metadata:
  name: thanos-tls
  namespace: kube-system
type: kubernetes.io/tls
data:
  ca.crt: >-
    ${DEV_THANOS_CHAIN}
  cacerts.pem: >-
    ${DEV_THANOS_CHAIN}
  tls.crt: >-
    ${DEV_THANOS_CRT}
  tls.key: >-
    ${DEV_THANOS_KEY}
---

---
kind: Secret
apiVersion: v1
metadata:
  name: thanos-key
  namespace: kube-system
data:
  objstore.yml: >-
    ${DEV_THANOS_GOOGLE_SERVICE_ACCOUNT}
type: Opaque
---