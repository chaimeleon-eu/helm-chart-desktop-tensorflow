{{/* vim: set filetype=mustache: */}}

{{/*
Chaimeleon annotations
*/}}
{{- define "chaimeleon.annotations" -}}
{{- if .Values.datasets_list }}
chaimeleon.eu/datasetsIDs: "{{ .Values.datasets_list }}"
{{- end }}
chaimeleon.eu/toolName: "{{ .Chart.Name }}"
chaimeleon.eu/toolVersion: "{{ .Chart.Version }}"
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
/home/chaimeleon/datasets
{{- end }}

{{- define "chaimeleon.datalake.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "datalake.path" -}}
{{- end }}

{{- define "chaimeleon.datalake.mount_point" -}}
/mnt/datalake
{{- end }}

{{- define "chaimeleon.persistent_home.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "persistent_home.path" -}}
{{- end }}

{{- define "chaimeleon.persistent_home.mount_point" -}}
/home/chaimeleon/persistent-home
{{- end }}

{{- define "chaimeleon.persistent_shared_folder.path" -}}
{{- $configmap := (lookup "v1" "ConfigMap" .Release.Namespace .Values.configmaps.chaimeleon) }}
{{- index $configmap "data" "persistent_shared_folder.path" -}}
{{- end }}

{{- define "chaimeleon.persistent_shared_folder.mount_point" -}}
/home/chaimeleon/persistent-shared-folder
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

