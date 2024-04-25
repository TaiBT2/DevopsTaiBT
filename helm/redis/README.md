helm upgrade --install redis -n s23dajinswap-dev --create-namespace oci://registry-1.docker.io/bitnamicharts/redis -f -<<EOF
architecture: standalone
auth:
  enabled: true
  existingSecret: ""
  existingSecretPasswordKey: ""
  password: bV0sX6331ffdqwN0dU2vB4y
  sentinel: false
  usePasswordFiles: false
clusterDomain: cluster.local
common:
  exampleValue: common-chart
  global:
    imagePullSecrets: []
    imageRegistry: ""
    redis:
      password: ""
    storageClass: openebs-hostpath
commonAnnotations: {}
commonConfiguration: |-
  # Enable AOF https://redis.io/topics/persistence#append-only-file
  appendonly yes
  # Disable RDB persistence, AOF persistence already enabled.
  save ""
commonLabels:
  company: synodus
  department: d5
  projectKey: s23dajinswap
global:
  imagePullSecrets: []
  imageRegistry: ""
  redis:
    password: ""
  storageClass: openebs-hostpath
image:
  debug: false
  digest: ""
  pullPolicy: IfNotPresent
  pullSecrets: []
  registry: docker.io
  repository: bitnami/redis
  tag: 6.2
kubeVersion: ""
master:
  affinity: {}
  args: []
  command: []
  configuration: ""
  containerPorts:
    redis: 6379
  count: 1
  disableCommands:
  - FLUSHDB
  - FLUSHALL
  livenessProbe:
    enabled: false
    failureThreshold: 5
    initialDelaySeconds: 20
    periodSeconds: 5
    successThreshold: 1
    timeoutSeconds: 5
  minReadySeconds: 0
  nodeAffinityPreset:
    key: ""
    type: ""
    values: []
  nodeSelector:
    kubernetes.io/hostname: dev-k8s-docker-node4-ip10-30
  persistence:
    accessModes:
    - ReadWriteOnce
    annotations: {}
    dataSource: {}
    enabled: true
    existingClaim: ""
    labels: {}
    medium: ""
    path: /data
    selector: {}
    size: 1Gi
    sizeLimit: ""
    storageClass: openebs-hostpath
    subPath: ""
    subPathExpr: ""
  persistentVolumeClaimRetentionPolicy:
    enabled: false
    whenDeleted: Retain
    whenScaled: Retain
  readinessProbe:
    enabled: true
    failureThreshold: 5
    initialDelaySeconds: 30
    periodSeconds: 30
    successThreshold: 1
    timeoutSeconds: 1
  resources:
    limits:
      cpu: 500m
      memory: 500Mi
    requests:
      cpu: 200m
      memory: 100Mi
  schedulerName: ""
  service:
    # annotations:
    #   metallb.universe.tf/allow-shared-ip: s22nbaeqxeca-svc
    clusterIP: ""
    externalIPs: []
    externalTrafficPolicy: Cluster
    extraPorts: []
    internalTrafficPolicy: Cluster
    loadBalancerIP: 10.0.10.117
    loadBalancerSourceRanges: []
    nodePorts:
      redis: "31568"
    ports:
      redis: 6379
    sessionAffinity: None
    sessionAffinityConfig: {}
    type: NodePort
  serviceAccount:
    annotations: {}
    automountServiceAccountToken: true
    create: false
    name: ""
  shareProcessNamespace: false
  sidecars: []
  startupProbe:
    enabled: false
    failureThreshold: 5
    initialDelaySeconds: 20
    periodSeconds: 5
    successThreshold: 1
    timeoutSeconds: 5
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoSchedule
    key: dedicated
    operator: Equal
    value: db
  topologySpreadConstraints: []
  updateStrategy:
    type: RollingUpdate
metrics:
  command: []
  containerSecurityContext:
    allowPrivilegeEscalation: false
    capabilities:
      drop:
      - ALL
    enabled: true
    runAsGroup: 0
    runAsNonRoot: true
    runAsUser: 1001
    seccompProfile:
      type: RuntimeDefault
  customLivenessProbe: {}
  customReadinessProbe: {}
  customStartupProbe: {}
  enabled: false
  extraArgs: {}
  extraEnvVars: []
  extraVolumeMounts: []
  extraVolumes: []
  image:
    digest: ""
    pullPolicy: IfNotPresent
    pullSecrets: []
    registry: docker.io
    repository: bitnami/redis-exporter
    tag: 1.52.0-debian-11-r25
  livenessProbe:
    enabled: true
    failureThreshold: 5
    initialDelaySeconds: 10
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 5
  podAnnotations:
    prometheus.io/port: "9121"
    prometheus.io/scrape: "true"
  podLabels: {}
  podMonitor:
    additionalLabels: {}
    enabled: false
    honorLabels: false
    interval: 30s
    metricRelabelings: []
    namespace: ""
    podTargetLabels: []
    relabellings: []
    sampleLimit: false
    scrapeTimeout: ""
    targetLimit: false
  prometheusRule:
    additionalLabels: {}
    enabled: false
    namespace: ""
    rules: []
  readinessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 5
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  redisTargetHost: localhost
  resources:
    limits: {}
    requests: {}
  service:
    annotations: {}
    clusterIP: ""
    externalTrafficPolicy: Cluster
    extraPorts: []
    loadBalancerIP: ""
    loadBalancerSourceRanges: []
    port: 9121
    type: ClusterIP
  serviceMonitor:
    additionalLabels: {}
    enabled: false
    honorLabels: false
    interval: 30s
    metricRelabelings: []
    namespace: ""
    podTargetLabels: []
    relabellings: []
    sampleLimit: false
    scrapeTimeout: ""
    targetLimit: false
  startupProbe:
    enabled: false
    failureThreshold: 5
    initialDelaySeconds: 10
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 5
pdb:
  create: false
  maxUnavailable: ""
  minAvailable: 1
podSecurityPolicy:
  create: false
  enabled: false
rbac:
  create: false
  rules: []
secretAnnotations: {}
serviceAccount:
  annotations: {}
  automountServiceAccountToken: true
  create: true
  name: ""
serviceBindings:
  enabled: false
sysctl:
  command: []
  enabled: false
  image:
    digest: ""
    pullPolicy: IfNotPresent
    pullSecrets: []
    registry: docker.io
    repository: bitnami/os-shell
    tag: 11-debian-11-r48
  mountHostSys: false
  resources:
    limits: {}
    requests: {}
tls:
  authClients: true
  autoGenerated: false
  certCAFilename: ""
  certFilename: ""
  certKeyFilename: ""
  certificatesSecret: ""
  dhParamsFilename: ""
  enabled: false
  existingSecret: ""
EOF
## Redis Replicas
```
helm upgrade  --install redis oci://registry-1.docker.io/bitnamicharts/redis -n devops --set global.storageClass=nfs-csi-retain
helm upgrade  --install redis oci://registry-1.docker.io/bitnamicharts/redis-cluster -n devops --set global.storageClass=nfs-csi-retain
```