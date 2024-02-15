{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "project.tplvaluesRender" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "project.tplvaluesRender" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}