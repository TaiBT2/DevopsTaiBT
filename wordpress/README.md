## INSTALL WORDPRESS
-  install mariadb
```
helm install mariadb oci://registry-1.docker.io/bitnamicharts/mariadb -n s23dajinswap-dev  -f - <<EOF
architecture: standalone
auth:
  customPasswordFiles: {}
  database: my_database
  existingSecret: ""
  forcePassword: false
  password: ""
  replicationPassword: ""
  replicationUser: replicator
  rootPassword: 1234567890aA
  usePasswordFiles: false
  username: ""
clusterDomain: cluster.local
common:
  exampleValue: common-chart
  global:
    imagePullSecrets: []
    imageRegistry: ""
    storageClass: ""
commonAnnotations: {}
commonLabels: {}
diagnosticMode:
  args:
  - infinity
  command:
  - sleep
  enabled: false
extraDeploy: []
fullnameOverride: ""
global:
  imagePullSecrets: []
  imageRegistry: ""
  storageClass: ""
image:
  debug: false
  digest: ""
  pullPolicy: IfNotPresent
  pullSecrets: []
  registry: docker.io
  repository: bitnami/mariadb
  tag: 10.3.32
initdbScripts: {}
initdbScriptsConfigMap: ""
kubeVersion: ""
metrics:
  annotations:
    prometheus.io/port: "9104"
    prometheus.io/scrape: "true"
  containerSecurityContext:
    allowPrivilegeEscalation: false
    enabled: false
    privileged: false
  enabled: false
  extraArgs:
    primary: []
    secondary: []
  extraVolumeMounts:
    primary: []
    secondary: []
  image:
    digest: ""
    pullPolicy: IfNotPresent
    pullSecrets: []
    registry: docker.io
    repository: bitnami/mysqld-exporter
    tag: 0.14.0-debian-11-r114
  livenessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 120
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  prometheusRule:
    additionalLabels: {}
    enabled: false
    namespace: ""
    rules: []
  readinessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 30
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  resources:
    limits: {}
    requests: {}
  serviceMonitor:
    enabled: false
    honorLabels: false
    interval: 30s
    jobLabel: ""
    labels: {}
    metricRelabelings: []
    namespace: ""
    relabelings: []
    scrapeTimeout: ""
    selector: {}
nameOverride: ""
networkPolicy:
  egressRules:
    customRules: {}
    denyConnectionsToExternal: false
  enabled: false
  ingressRules:
    primaryAccessOnlyFrom:
      customRules: []
      enabled: false
      namespaceSelector: {}
      podSelector: {}
    secondaryAccessOnlyFrom:
      customRules: []
      enabled: false
      namespaceSelector: {}
      podSelector: {}
  metrics:
    enabled: false
    namespaceSelector: {}
    podSelector: {}
primary:
  affinity: {}
  args: []
  command: []
  configuration: |-
    [mysqld]
    skip-name-resolve
    explicit_defaults_for_timestamp
    basedir=/opt/bitnami/mariadb
    plugin_dir=/opt/bitnami/mariadb/plugin
    port=3306
    socket=/opt/bitnami/mariadb/tmp/mysql.sock
    tmpdir=/opt/bitnami/mariadb/tmp
    max_allowed_packet=16M
    bind-address=*
    pid-file=/opt/bitnami/mariadb/tmp/mysqld.pid
    log-error=/opt/bitnami/mariadb/logs/mysqld.log
    character-set-server=UTF8
    collation-server=utf8_general_ci
    slow_query_log=0
    slow_query_log_file=/opt/bitnami/mariadb/logs/mysqld.log
    long_query_time=10.0

    [client]
    port=3306
    socket=/opt/bitnami/mariadb/tmp/mysql.sock
    default-character-set=UTF8
    plugin_dir=/opt/bitnami/mariadb/plugin

    [manager]
    port=3306
    socket=/opt/bitnami/mariadb/tmp/mysql.sock
    pid-file=/opt/bitnami/mariadb/tmp/mysqld.pid
  containerSecurityContext:
    allowPrivilegeEscalation: false
    enabled: true
    privileged: false
    runAsNonRoot: true
    runAsUser: 1001
  customLivenessProbe: {}
  customReadinessProbe: {}
  customStartupProbe: {}
  existingConfigmap: ""
  extraEnvVars: []
  extraEnvVarsCM: ""
  extraEnvVarsSecret: ""
  extraFlags: ""
  extraVolumeMounts: []
  extraVolumes: []
  hostAliases: []
  initContainers: []
  lifecycleHooks: {}
  livenessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 120
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  name: primary
  nodeAffinityPreset:
    key: ""
    type: ""
    values: []
  nodeSelector: {}
  pdb:
    create: false
    maxUnavailable: ""
    minAvailable: 1
  persistence:
    accessModes:
    - ReadWriteOnce
    annotations: {}
    enabled: true
    existingClaim: ""
    labels: {}
    selector: {}
    size: 10Gi
    storageClass: ""
    subPath: ""
  podAffinityPreset: ""
  podAnnotations: {}
  podAntiAffinityPreset: soft
  podLabels: {}
  podManagementPolicy: ""
  podSecurityContext:
    enabled: true
    fsGroup: 1001
  priorityClassName: ""
  readinessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 30
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  resources:
    limits: {}
    requests: {}
  revisionHistoryLimit: 10
  rollingUpdatePartition: ""
  runtimeClassName: ""
  schedulerName: ""
  service:
    annotations: {}
    clusterIP: ""
    externalTrafficPolicy: Cluster
    extraPorts: []
    loadBalancerIP: ""
    loadBalancerSourceRanges: []
    ports:
      metrics: 9104
      mysql: 3306
    sessionAffinity: None
    sessionAffinityConfig: {}
    type: ClusterIP
  sidecars: []
  startupProbe:
    enabled: false
    failureThreshold: 10
    initialDelaySeconds: 120
    periodSeconds: 15
    successThreshold: 1
    timeoutSeconds: 5
  startupWaitOptions: {}
  tolerations: []
  topologySpreadConstraints: []
  updateStrategy:
    type: RollingUpdate
rbac:
  create: false
runtimeClassName: ""
schedulerName: ""
secondary:
  affinity: {}
  args: []
  command: []
  configuration: |-
    [mysqld]
    skip-name-resolve
    explicit_defaults_for_timestamp
    basedir=/opt/bitnami/mariadb
    port=3306
    socket=/opt/bitnami/mariadb/tmp/mysql.sock
    tmpdir=/opt/bitnami/mariadb/tmp
    max_allowed_packet=16M
    bind-address=0.0.0.0
    pid-file=/opt/bitnami/mariadb/tmp/mysqld.pid
    log-error=/opt/bitnami/mariadb/logs/mysqld.log
    character-set-server=UTF8
    collation-server=utf8_general_ci
    slow_query_log=0
    slow_query_log_file=/opt/bitnami/mariadb/logs/mysqld.log
    long_query_time=10.0

    [client]
    port=3306
    socket=/opt/bitnami/mariadb/tmp/mysql.sock
    default-character-set=UTF8

    [manager]
    port=3306
    socket=/opt/bitnami/mariadb/tmp/mysql.sock
    pid-file=/opt/bitnami/mariadb/tmp/mysqld.pid
  containerSecurityContext:
    allowPrivilegeEscalation: false
    enabled: true
    privileged: false
    runAsNonRoot: true
    runAsUser: 1001
  customLivenessProbe: {}
  customReadinessProbe: {}
  customStartupProbe: {}
  existingConfigmap: ""
  extraEnvVars: []
  extraEnvVarsCM: ""
  extraEnvVarsSecret: ""
  extraFlags: ""
  extraVolumeMounts: []
  extraVolumes: []
  hostAliases: []
  initContainers: []
  lifecycleHooks: {}
  livenessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 120
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  name: secondary
  nodeAffinityPreset:
    key: ""
    type: ""
    values: []
  nodeSelector: {}
  pdb:
    create: false
    maxUnavailable: ""
    minAvailable: 1
  persistence:
    accessModes:
    - ReadWriteOnce
    annotations: {}
    enabled: true
    labels: {}
    selector: {}
    size: 8Gi
    storageClass: ""
    subPath: ""
  podAffinityPreset: ""
  podAnnotations: {}
  podAntiAffinityPreset: soft
  podLabels: {}
  podManagementPolicy: ""
  podSecurityContext:
    enabled: true
    fsGroup: 1001
  priorityClassName: ""
  readinessProbe:
    enabled: true
    failureThreshold: 3
    initialDelaySeconds: 30
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 1
  replicaCount: 1
  resources:
    limits: {}
    requests: {}
  revisionHistoryLimit: 10
  rollingUpdatePartition: ""
  runtimeClassName: ""
  schedulerName: ""
  service:
    annotations: {}
    clusterIP: ""
    externalTrafficPolicy: Cluster
    extraPorts: []
    loadBalancerIP: ""
    loadBalancerSourceRanges: []
    nodePorts:
      mysql: ""
    ports:
      metrics: 9104
      mysql: 3306
    sessionAffinity: None
    sessionAffinityConfig: {}
    type: ClusterIP
  sidecars: []
  startupProbe:
    enabled: false
    failureThreshold: 10
    initialDelaySeconds: 120
    periodSeconds: 15
    successThreshold: 1
    timeoutSeconds: 5
  startupWaitOptions: {}
  tolerations: []
  topologySpreadConstraints: []
  updateStrategy:
    type: RollingUpdate
serviceAccount:
  annotations: {}
  automountServiceAccountToken: false
  create: true
  name: ""
serviceBindings:
  enabled: false
volumePermissions:
  enabled: false
  image:
    digest: ""
    pullPolicy: IfNotPresent
    pullSecrets: []
    registry: docker.io
    repository: bitnami/bitnami-shell
    tag: 11-debian-11-r112
  resources:
    limits: {}
    requests: {}
EOF
```
- install wordpress
```
helm upgrade --install s23dajinswap-wordpress oci://registry-1.docker.io/bitnamicharts/wordpress -n s23dajinswap-dev \
	--set mariadb.enabled=false \
    --set externalDatabase.host=mariadb.s23dajinswap-dev.svc.cluster.local \
	--set externalDatabase.user=root \
	--set externalDatabase.password=1234567890aA \
	--set externalDatabase.database=my_database \
	--set externalDatabase.port=3306
```
- add more ssh server to wordpress
```
    - name: ssh-server
      image: linuxserver/openssh-server
      ports:
        - name: ssh
          containerPort: 2222
          protocol: TCP
      env:
        - name: PASSWORD_ACCESS
          value: 'true'
        - name: USER_PASSWORD
          value: cN5iW6gV1lP1xS2w
        - name: USER_NAME
          value: webadmin
        - name: SUDO_ACCESS
          value: 'true'
        - name: TZ
          value: Asia/Ho_Chi_Minh
      resources: {}
      volumeMounts:
        - name: www-storage
          mountPath: /opt/synodus.com
        - name: kube-api-access-r6qp5
          readOnly: true
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      imagePullPolicy: Always
```