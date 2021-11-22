{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "desktop-tensorflow.chartName" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "desktop-tensorflow.fullname" -}}
{{- if contains .Chart.Name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "desktop-tensorflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "desktop-tensorflow.labels" -}}
helm.sh/chart: {{ include "desktop-tensorflow.chart" . }}
{{ include "desktop-tensorflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/app-version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- if .Chart.Version }}
app.kubernetes.io/version: {{ .Chart.Version | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "desktop-tensorflow.selectorLabels" -}}
app.kubernetes.io/name: {{ include "desktop-tensorflow.chartName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "desktop-tensorflow.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "desktop-tensorflow.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "desktop-tensorflow.container-password" -}}
{{- if .Release.IsInstall }}
{{- randAlphaNum 20 -}}
{{ else }}
{{- index (lookup "v1" "Secret" .Release.Namespace "{{ .Chart.Name }}-{{ .Values.name }}").data "container-password" -}}
{{- end }}
{{- end }}

{{- define "desktop-tensorflow.id" -}}
{{- if .Release.IsInstall }}
{{- randAlphaNum 20 | b64enc -}}
{{ else }}
{{- index (lookup "v1" "Secret" .Release.Namespace "{{ .Chart.Name }}-{{ .Values.name }}").data "container-password" -}}
{{- end }}
{{- end }}



{{/*
Obtain chaimeleon common variables
*/}}
{{- define "chaimeleon.ceph.user" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "ceph.user" | default (printf "%s-%s" "chaimeleon-user" .Release.Namespace) -}}
{{- end }}

{{- define "chaimeleon.ceph.gid" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "ceph.gid"  | int | default 1000 -}}
{{- end }}

{{- define "chaimeleon.ceph.monitor" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "ceph.monitor" -}}
{{- end }}

{{- define "chaimeleon.datasets.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "datasets.path" -}}
{{- end }}

{{- define "chaimeleon.datasets.mount_point" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "datasets.mount_point" -}}
{{- end }}

{{- define "chaimeleon.datalake.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "datalake.path" -}}
{{- end }}

{{- define "chaimeleon.datalake.mount_point" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "datalake.mount_point" -}}
{{- end }}

{{- define "chaimeleon.persistent_home.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "persistent_home.path" -}}
{{- end }}

{{- define "chaimeleon.persistent_home.mount_point" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "persistent_home.mount_point" -}}
{{- end }}


{{- define "chaimeleon.user.name" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "user.name" -}}
{{- end }}

{{- define "chaimeleon.user.uid" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "user.uid" | int -}}
{{- end }}

{{- define "chaimeleon.group.name" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "group.name" -}}
{{- end }}

{{- define "chaimeleon.group.gid" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "group.gid" | int -}}
{{- end }}


{{/*
Print the name for the Guacamole connection.
*/}}
{{- define "desktop-tensorflow.connectionName" }}
{{ now | date "2006-01-02-15-04-05" }}--{{ include "desktop-tensorflow.fullname" . }}
{{- end }}

{{/*
Print a random string (useful for generate passwords).
*/}}
{{- define "desktop-tensorflow.randomString" }}
{{- randAlphaNum 20 -}}
{{- end }}
