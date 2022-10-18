# Changelog

{{- range $change_type, $change_list := .changes }}

{{- if eq $change_type "added" }}
## Added
{{- range $change := $change_list }}
- {{ $change }}
{{- end -}}
{{- end -}}

{{- if eq $change_type "changed" }}
## Changed
{{- range $change := $change_list }}
- {{ $change }}
{{- end -}}
{{- end -}}

{{- end -}}
