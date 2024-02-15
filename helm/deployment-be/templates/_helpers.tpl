{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "project.fullname" -}}
{{- if and .Values.fullnameOverride .Values.environmentZone -}}
{{- printf "%s-%s" .Values.fullnameOverride .Values.environmentZone | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.fullnameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.environmentZone | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "project.namespace" -}}
{{- if .Values.namespace -}}
{{- include "project.tplvaluesRender" ( dict "value" .Values.namespace "context" $ )  | quote -}}
{{- else -}}
{{- include "project.tplvaluesRender" ( dict "value" .Release.Namespace "context" $ )  | quote -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Labels to use on deployment.spec.selector.matchLabels and service.spec.selector
*/}}
{{- define "project.matchLabels" -}}
{{- if .Values.commonLabels.project -}}
project: {{ include "project.tplvaluesRender" ( dict "value" .Values.commonLabels.project "context" . ) }}
{{- end }}
app.kubernetes.io/name: {{ include "project.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.environmentZone }}
environment-zone: {{ .Values.environmentZone | quote }}
{{- end }}
{{- if .Values.type }}
application-tier: {{ .Values.type | quote }}
{{- end }}
{{- end -}}

{{/*
Standards labels
*/}}
{{- define "project.standardLabels" -}}
helm.sh/chart: {{ include "project.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "project.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.environmentZone }}
environment-zone: {{ .Values.environmentZone | quote }}
{{- end }}
{{- if .Values.type }}
application-tier: {{ .Values.type | quote }}
{{- end }}
{{- end -}}

{{/*
Return the configuration deployment
*/}}
{{- define "project.deploymentName" -}}
{{- if .Values.service.name -}}
    {{- printf "%s-deployment" (include "project.fullname" $) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "project.createConfigmap" -}}
{{- if and .Values.configmap.createConfigmap (not .Values.configmap.existingConfigmap) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a service object should be created
*/}}
{{- define "project.createService" -}}
{{- if .Values.service }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a ingress rule object should be created
*/}}
{{- define "project.createIngressRule" -}}
{{- if .Values.ingress }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the configuration configmap for Normal service
*/}}
{{- define "project.configMapEnvVar" -}}
{{- if .Values.configmap.existingConfigmap -}}
    {{- printf "%s" ( tpl .Values.configmap.existingConfigmap $ ) -}}
{{- else -}}
    {{- printf "%s-envcfg" (include "project.fullname" $) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the configuration configmap for Ingress
*/}}
{{- define "project.configMapWeb" -}}
{{- if .Values.configmap.existingConfigmap -}}
    {{- printf "%s" ( tpl .Values.configmap.existingConfigmap $ ) -}}
{{- else -}}
    {{- printf "%s-webcfg" (include "project.fullname" $) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "project.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{- printf "%s" ( tpl .Values.serviceAccount.name $ ) -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service to use
*/}}
{{- define "project.serviceName" -}}
{{- if .Values.service.name -}}
    {{- printf "%s-svc" (include "project.fullname" $) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the ingress to use
*/}}
{{- define "project.ingressName" -}}
{{- if .Values.service.name -}}
    {{- printf "%s-ingress" (include "project.fullname" $) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create the annotations for Rolling Update by reloader
*/}}
{{- define "project.reloader" -}}
configmap.reloader.stakater.com/reload: {{ .Values.customAnnotations.reloader.mode | quote }}
{{- end }}

{{/*
Create the annotations for Rolling Update by hash
*/}}
{{- define "project.checksum" -}}
checksum/deployment: {{ include "project.tplvaluesRender" ( dict "value" .Values "context" $ ) | sha256sum }}
{{- if .Values.webconfig }}
checksum/config: {{ include "project.tplvaluesRender" ( dict "value" .Values.webconfig "context" $ ) | sha256sum }}
{{- end }}
{{- if .Values.environmentVariables }}
checksum/config: {{ include "project.tplvaluesRender" ( dict "value" .Values.environmentVariables "context" . ) | sha256sum }}
{{- end }}
{{- if .Values.service }}
checksum/service: {{ include "project.tplvaluesRender" ( dict "value" .Values.service "context" . ) | sha256sum }}
{{- end }}
{{- if .Values.ingress }}
checksum/ingress: {{ include "project.tplvaluesRender" ( dict "value" .Values.ingress "context" . ) | sha256sum }}
{{- end }}
{{- end -}}