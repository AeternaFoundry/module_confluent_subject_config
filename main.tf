resource "confluent_subject_config" "subject_configs" {
  for_each = var.subject_configs

  subject_name        = each.value.subject_name
  alias               = each.value.alias
  compatibility_group = each.value.compatibility_group
  compatibility_level = each.value.compatibility_level
  normalize           = each.value.normalize
  rest_endpoint       = each.value.rest_endpoint

  dynamic "credentials" {
    for_each = each.value.credentials != null ? [each.value.credentials] : []
    content {
      key    = credentials.value.key
      secret = credentials.value.secret
    }
  }

  dynamic "schema_registry_cluster" {
    for_each = each.value.schema_registry_cluster != null ? [each.value.schema_registry_cluster] : []
    content {
      id = schema_registry_cluster.value.id
    }
  }
}

