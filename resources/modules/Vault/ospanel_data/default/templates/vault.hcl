storage "file" {
    path = "{root_dir}/data/{module_name}/{profile_name}"
}

listener "tcp" {
    address                            = "{ip}:{port}"
    cluster_address                    = ""
    
	# TLS configuration
    tls_disable                        = false
    tls_cert_file                      = "{root_dir}/data/ssl/modules/{module_name}/cert.crt"
    tls_key_file                       = "{root_dir}/data/ssl/modules/{module_name}/cert.key"
    tls_min_version                    = "tls12"
    tls_max_version                    = "tls13"

    # Client certificates (optional)
    # -----------------------------------------------------------------
    tls_client_ca_file                 = "{root_dir}/data/ssl/root/cert.crt"
    tls_disable_client_certs           = true
    tls_require_and_verify_client_cert = false

    # HTTP security headers
    # -----------------------------------------------------------------
    # http_read_header_timeout         = "10s"
    # http_read_timeout                = "30s"
    # http_write_timeout               = "30s"
    # http_idle_timeout                = "5m"

    # CORS
    # -----------------------------------------------------------------
    # cors_enabled                     = true
    # cors_allowed_origins             = ["https://vault.example.com"]

    # Proxy protocol (if behind load balancer)
    # -----------------------------------------------------------------
    # proxy_protocol_behavior          = "allow_authorized"
    # proxy_protocol_authorized_addrs  = ["127.0.0.1/32", "10.0.0.0/8"]

    # X-Forwarded-For
    # -----------------------------------------------------------------
    # x_forwarded_for_authorized_addrs       = ["127.0.0.1/32", "10.0.0.0/8"]
    # x_forwarded_for_hop_skips              = "0"
    # x_forwarded_for_reject_not_authorized  = true
    # x_forwarded_for_reject_not_present     = true
}

# Core Configuration
# -----------------------------------------------------------------
api_addr                   = "https://{module_name}:{port}"
default_lease_ttl          = "768h"
disable_mlock              = true
max_lease_ttl              = "8760h"
pid_file                   = "{root_dir}/temp/{module_name}.pid"
plugin_directory           = "{root_dir}/modules/{module_name}/plugins"
raw_storage_endpoint       = false
ui                         = true

# Logging
# -----------------------------------------------------------------
# log_level                = "{log_level}"
# log_format               = "standard"
# log_file                 = "{root_dir}/logs/{module_name}/server.log"
# log_rotate_duration      = "24h"
# log_rotate_bytes         = 104857600
# log_rotate_max_files     = 30

# Telemetry and metrics
# -----------------------------------------------------------------
# telemetry {
#     disable_hostname     = false
#     prometheus_retention_time = "24h"
#
#     # StatsD (optional)
#     statsd_address       = "127.0.0.1:8125"
#
#     # Circonus (optional)
#     circonus_api_token   = "your-token"
#     circonus_api_app     = "vault"
#     circonus_submission_interval = "10s"
#
#     # DogStatsD (optional)
#     dogstatsd_addr       = "127.0.0.1:8125"
#     dogstatsd_tags       = ["environment:production", "service:vault"]
# }

# Seal configuration
# -----------------------------------------------------------------
# seal "transit" {
#     address              = "https://vault-primary:8200"
#     token                = "s.xxxxxxxxxxxx"
#     key_name             = "unseal-key"
#     mount_path           = "transit"
# }

# Additional listeners (e.g., for internal network without TLS)
# -----------------------------------------------------------------
# listener "tcp" {
#     address              = "{ip}:8300"
#     tls_disable          = true
# }