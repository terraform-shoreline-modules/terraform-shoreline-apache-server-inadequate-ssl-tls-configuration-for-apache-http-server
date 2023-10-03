resource "shoreline_notebook" "inadequate_ssl_tls_configuration_for_apache_http_server" {
  name       = "inadequate_ssl_tls_configuration_for_apache_http_server"
  data       = file("${path.module}/data/inadequate_ssl_tls_configuration_for_apache_http_server.json")
  depends_on = [shoreline_action.invoke_apache_security_audit]
}

resource "shoreline_file" "apache_security_audit" {
  name             = "apache_security_audit"
  input_file       = "${path.module}/data/apache_security_audit.sh"
  md5              = filemd5("${path.module}/data/apache_security_audit.sh")
  description      = "The first step to remediate this incident type is to identify the specific SSL/TLS configuration vulnerabilities that exist in the Apache HTTP Server. This can be done by conducting a security audit of the server configuration and identifying any weaknesses or misconfigurations."
  destination_path = "/agent/scripts/apache_security_audit.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_security_audit" {
  name        = "invoke_apache_security_audit"
  description = "The first step to remediate this incident type is to identify the specific SSL/TLS configuration vulnerabilities that exist in the Apache HTTP Server. This can be done by conducting a security audit of the server configuration and identifying any weaknesses or misconfigurations."
  command     = "`chmod +x /agent/scripts/apache_security_audit.sh && /agent/scripts/apache_security_audit.sh`"
  params      = []
  file_deps   = ["apache_security_audit"]
  enabled     = true
  depends_on  = [shoreline_file.apache_security_audit]
}

