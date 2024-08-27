# redis-ha

![Version: 4.26.1](https://img.shields.io/badge/Version-4.26.1-informational?style=flat-square) ![AppVersion: 7.2.4](https://img.shields.io/badge/AppVersion-7.2.4-informational?style=flat-square)

This Helm chart provides a highly available Redis implementation with a master/slave configuration and uses Sentinel sidecars for failover management

**Homepage:** <http://redis.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ssalaues | <salimsalaues@gmail.com> |  |
| dandydeveloper | <aaron.layfield@gmail.com> |  |

## Source Code

* <https://redis.io/download>
* <https://github.com/DandyDeveloper/charts/blob/master/charts/redis-ha>
* <https://github.com/oliver006/redis_exporter>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalAffinities | object | `{}` |  |
| affinity | string | `""` |  |
| auth | bool | `false` |  |
| authKey | string | `"auth"` |  |
| configmap.labels | object | `{}` |  |
| configmapTest.image.repository | string | `"koalaman/shellcheck"` |  |
| configmapTest.image.tag | string | `"v0.5.0"` |  |
| configmapTest.resources | object | `{}` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1000` |  |
| containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| emptyDir | object | `{}` |  |
| exporter.address | string | `"localhost"` |  |
| exporter.enabled | bool | `false` |  |
| exporter.extraArgs | object | `{}` |  |
| exporter.image | string | `"oliver006/redis_exporter"` |  |
| exporter.livenessProbe.initialDelaySeconds | int | `15` |  |
| exporter.livenessProbe.periodSeconds | int | `15` |  |
| exporter.livenessProbe.timeoutSeconds | int | `3` |  |
| exporter.port | int | `9121` |  |
| exporter.portName | string | `"exporter-port"` |  |
| exporter.pullPolicy | string | `"IfNotPresent"` |  |
| exporter.readinessProbe.initialDelaySeconds | int | `15` |  |
| exporter.readinessProbe.periodSeconds | int | `15` |  |
| exporter.readinessProbe.successThreshold | int | `2` |  |
| exporter.readinessProbe.timeoutSeconds | int | `3` |  |
| exporter.resources | object | `{}` |  |
| exporter.scrapePath | string | `"/metrics"` |  |
| exporter.serviceMonitor.enabled | bool | `false` |  |
| exporter.serviceMonitor.endpointAdditionalProperties | object | `{}` |  |
| exporter.serviceMonitor.labels | object | `{}` |  |
| exporter.tag | string | `"v1.57.0"` |  |
| extraContainers | list | `[]` |  |
| extraInitContainers | list | `[]` |  |
| extraLabels | object | `{}` |  |
| extraVolumes | list | `[]` |  |
| haproxy.IPv6.enabled | bool | `true` |  |
| haproxy.additionalAffinities | object | `{}` |  |
| haproxy.affinity | string | `""` |  |
| haproxy.annotations | object | `{}` |  |
| haproxy.checkFall | int | `1` |  |
| haproxy.checkInterval | string | `"1s"` |  |
| haproxy.containerPort | int | `6379` |  |
| haproxy.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| haproxy.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| haproxy.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| haproxy.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| haproxy.deploymentStrategy | object | `{"type":"RollingUpdate"}` | Deployment strategy for the haproxy deployment |
| haproxy.emptyDir | object | `{}` |  |
| haproxy.enabled | bool | `false` |  |
| haproxy.hardAntiAffinity | bool | `true` |  |
| haproxy.image.pullPolicy | string | `"IfNotPresent"` |  |
| haproxy.image.repository | string | `"haproxy"` |  |
| haproxy.image.tag | string | `"2.9.4-alpine"` |  |
| haproxy.imagePullSecrets | list | `[]` |  |
| haproxy.init.resources | object | `{}` |  |
| haproxy.labels | object | `{}` |  |
| haproxy.lifecycle | object | `{}` |  |
| haproxy.metrics.enabled | bool | `false` |  |
| haproxy.metrics.port | int | `9101` |  |
| haproxy.metrics.portName | string | `"http-exporter-port"` |  |
| haproxy.metrics.scrapePath | string | `"/metrics"` |  |
| haproxy.metrics.serviceMonitor.enabled | bool | `false` |  |
| haproxy.metrics.serviceMonitor.endpointAdditionalProperties | object | `{}` |  |
| haproxy.metrics.serviceMonitor.labels | object | `{}` |  |
| haproxy.networkPolicy.annotations | object | `{}` |  |
| haproxy.networkPolicy.egressRules | list | `[]` |  |
| haproxy.networkPolicy.enabled | bool | `false` |  |
| haproxy.networkPolicy.ingressRules | list | `[]` |  |
| haproxy.networkPolicy.labels | object | `{}` |  |
| haproxy.podDisruptionBudget | object | `{}` |  |
| haproxy.readOnly.enabled | bool | `false` |  |
| haproxy.readOnly.port | int | `6380` |  |
| haproxy.replicas | int | `3` |  |
| haproxy.resources | object | `{}` |  |
| haproxy.securityContext.fsGroup | int | `99` |  |
| haproxy.securityContext.runAsNonRoot | bool | `true` |  |
| haproxy.securityContext.runAsUser | int | `99` |  |
| haproxy.service.annotations | string | `nil` |  |
| haproxy.service.externalIPs | object | `{}` |  |
| haproxy.service.labels | object | `{}` |  |
| haproxy.service.loadBalancerIP | string | `nil` |  |
| haproxy.service.type | string | `"ClusterIP"` |  |
| haproxy.serviceAccount.create | bool | `true` |  |
| haproxy.serviceAccountName | string | `"redis-sa"` |  |
| haproxy.servicePort | int | `6379` |  |
| haproxy.stickyBalancing | bool | `false` |  |
| haproxy.tests.resources | object | `{}` |  |
| haproxy.timeout.check | string | `"2s"` |  |
| haproxy.timeout.client | string | `"330s"` |  |
| haproxy.timeout.connect | string | `"4s"` |  |
| haproxy.timeout.server | string | `"330s"` |  |
| haproxy.tls.certMountPath | string | `"/tmp/"` |  |
| haproxy.tls.enabled | bool | `false` |  |
| haproxy.tls.keyName | string | `nil` |  |
| haproxy.tls.secretName | string | `""` |  |
| hardAntiAffinity | bool | `true` |  |
| hostPath.chown | bool | `true` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"redis"` |  |
| image.tag | string | `"7.2.4-alpine"` |  |
| imagePullSecrets | list | `[]` |  |
| init.resources | object | `{}` |  |
| labels | object | `{}` |  |
| networkPolicy.annotations | object | `{}` |  |
| networkPolicy.egressRules | list | `[]` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingressRules | list | `[]` |  |
| networkPolicy.labels | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| persistentVolume.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistentVolume.annotations | object | `{}` |  |
| persistentVolume.enabled | bool | `true` |  |
| persistentVolume.labels | object | `{}` |  |
| persistentVolume.size | string | `"10Gi"` |  |
| podDisruptionBudget | object | `{}` |  |
| podManagementPolicy | string | `"OrderedReady"` |  |
| prometheusRule.additionalLabels | object | `{}` | Additional labels to be set in metadata. |
| prometheusRule.enabled | bool | `false` | If true, creates a Prometheus Operator PrometheusRule. |
| prometheusRule.interval | string | `"10s"` | How often rules in the group are evaluated (falls back to `global.evaluation_interval` if not set). |
| prometheusRule.namespace | string | `nil` | Namespace which Prometheus is running in. |
| prometheusRule.rules | list | `[]` | Rules spec template (see https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#rule). |
| rbac.create | bool | `true` |  |
| redis.annotations | object | `{}` |  |
| redis.config.maxmemory | string | `"0"` |  |
| redis.config.maxmemory-policy | string | `"volatile-lru"` |  |
| redis.config.min-replicas-max-lag | int | `5` |  |
| redis.config.min-replicas-to-write | int | `1` |  |
| redis.config.rdbchecksum | string | `"yes"` |  |
| redis.config.rdbcompression | string | `"yes"` |  |
| redis.config.repl-diskless-sync | string | `"yes"` |  |
| redis.config.save | string | `"900 1"` |  |
| redis.disableCommands[0] | string | `"FLUSHDB"` |  |
| redis.disableCommands[1] | string | `"FLUSHALL"` |  |
| redis.extraVolumeMounts | list | `[]` |  |
| redis.lifecycle.preStop.exec.command[0] | string | `"/bin/sh"` |  |
| redis.lifecycle.preStop.exec.command[1] | string | `"/readonly-config/trigger-failover-if-master.sh"` |  |
| redis.livenessProbe.failureThreshold | int | `5` |  |
| redis.livenessProbe.initialDelaySeconds | int | `30` |  |
| redis.livenessProbe.periodSeconds | int | `15` |  |
| redis.livenessProbe.successThreshold | int | `1` |  |
| redis.livenessProbe.timeoutSeconds | int | `15` |  |
| redis.masterGroupName | string | `"mymaster"` |  |
| redis.port | int | `6379` |  |
| redis.readinessProbe.failureThreshold | int | `5` |  |
| redis.readinessProbe.initialDelaySeconds | int | `30` |  |
| redis.readinessProbe.periodSeconds | int | `15` |  |
| redis.readinessProbe.successThreshold | int | `1` |  |
| redis.readinessProbe.timeoutSeconds | int | `15` |  |
| redis.resources | object | `{}` |  |
| redis.terminationGracePeriodSeconds | int | `60` |  |
| redis.updateStrategy.type | string | `"RollingUpdate"` |  |
| replicas | int | `3` |  |
| restore.existingSecret | bool | `false` |  |
| restore.s3.access_key | string | `""` |  |
| restore.s3.region | string | `""` |  |
| restore.s3.secret_key | string | `""` |  |
| restore.s3.source | bool | `false` |  |
| restore.ssh.key | string | `""` |  |
| restore.ssh.source | bool | `false` |  |
| restore.timeout | int | `600` |  |
| ro_replicas | string | `""` |  |
| securityContext.fsGroup | int | `1000` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| sentinel.auth | bool | `false` |  |
| sentinel.authKey | string | `"sentinel-password"` |  |
| sentinel.config.down-after-milliseconds | int | `10000` |  |
| sentinel.config.failover-timeout | int | `180000` |  |
| sentinel.config.maxclients | int | `10000` |  |
| sentinel.config.parallel-syncs | int | `5` |  |
| sentinel.extraVolumeMounts | list | `[]` |  |
| sentinel.lifecycle | object | `{}` |  |
| sentinel.livenessProbe.failureThreshold | int | `5` |  |
| sentinel.livenessProbe.initialDelaySeconds | int | `30` |  |
| sentinel.livenessProbe.periodSeconds | int | `15` |  |
| sentinel.livenessProbe.successThreshold | int | `1` |  |
| sentinel.livenessProbe.timeoutSeconds | int | `15` |  |
| sentinel.port | int | `26379` |  |
| sentinel.quorum | int | `2` |  |
| sentinel.readinessProbe.failureThreshold | int | `5` |  |
| sentinel.readinessProbe.initialDelaySeconds | int | `30` |  |
| sentinel.readinessProbe.periodSeconds | int | `15` |  |
| sentinel.readinessProbe.successThreshold | int | `3` |  |
| sentinel.readinessProbe.timeoutSeconds | int | `15` |  |
| sentinel.resources | object | `{}` |  |
| serviceAccount.automountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceLabels | object | `{}` |  |
| splitBrainDetection.interval | int | `60` |  |
| splitBrainDetection.resources | object | `{}` |  |
| sysctlImage.command | list | `[]` |  |
| sysctlImage.enabled | bool | `false` |  |
| sysctlImage.mountHostSys | bool | `false` |  |
| sysctlImage.pullPolicy | string | `"Always"` |  |
| sysctlImage.registry | string | `"docker.io"` |  |
| sysctlImage.repository | string | `"busybox"` |  |
| sysctlImage.resources | object | `{}` |  |
| sysctlImage.tag | string | `"1.34.1"` |  |
| tls.caCertFile | string | `"ca.crt"` |  |
| tls.certFile | string | `"redis.crt"` |  |
| tls.keyFile | string | `"redis.key"` |  |
| topologySpreadConstraints.enabled | bool | `false` |  |
| topologySpreadConstraints.maxSkew | string | `""` |  |
| topologySpreadConstraints.topologyKey | string | `""` |  |
| topologySpreadConstraints.whenUnsatisfiable | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
