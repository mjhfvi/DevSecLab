# disable memory from being swapped to disk
disable_mlock = true

# API listener configuration block
listener "tcp" {
  # The purpose of this listener block
  purpose = "api"

  # Should be the address of the NIC that the controller server will be reached on
  # Use 0.0.0.0 to listen on all interfaces
  address = "0.0.0.0:9200"

  # TLS Configuration
  tls_disable   = true
  # tls_cert_file = "/etc/boundary.d/tls/boundary-cert.pem"
  # tls_key_file  = "/etc/boundary.d/tls/boundary-key.pem"

  # Uncomment to enable CORS for the Admin UI. Be sure to set the allowed origin(s)
  # to appropriate values.
  cors_enabled = false
  #cors_allowed_origins = ["https://yourcorp.yourdomain.com", "serve://boundary"]
}

# cluster listener configuration block (used for worker coordination)
listener "tcp" {
  # The purpose of this listener
  purpose = "cluster"

  # Should be the IP of the NIC that the worker will connect on
  address = "0.0.0.0:9201"

  # TLS Configuration
  tls_disable   = true
}

# Ops listener for operations like health checks for load balancers
listener "tcp" {
  # Should be the address of the interface where your external systems'
  # (eg: Load-Balancer and metrics collectors) will connect on.
  address = "0.0.0.0:9203"
  # The purpose of this listener block
  purpose = "ops"

  tls_disable   = true
  # tls_cert_file = "/etc/boundary.d/tls/boundary-cert.pem"
  # tls_key_file  = "/etc/boundary.d/tls/boundary-key.pem"
}

# Controller configuration block
controller {
  # This name attr must be unique across all controller instances if running in HA mode
  name = "boundary-controller"
  description = "Main Boundary controller"

  # This is the public hostname or IP where the workers can reach the controller.
  # This should typically be a load balancer address
  public_cluster_addr = "192.168.50.50"

  # After receiving a shutdown signal, Boundary will wait 10s before initiating the shutdown process.
  graceful_shutdown_wait_duration = "2s"

  # Database URL for postgres. This is set in boundary.env and consumed via the “env://” notation.
  database {
      # url = "postgresql://adminuser:12345@192.168.50.50/boundary"
      url = "file://db.hcl"
      max_open_connections = 10
      max_idle_connections = 3
      max_idle_time = "30m"
  }
}

# Root KMS Key (managed by AWS KMS in this example)
# Keep in mind that sensitive values are provided via ENV VARS
# in this example, such as access_key and secret_key
kms "aead" {
    purpose = "root"
    aead_type = "aes-gcm"
    key = ""
    key_id = "global_root"
}

# Worker authorization KMS
# Use a production KMS such as AWS KMS for production installs
# This key is the same key used in the worker configuration
# kms "aead" {
#   purpose = "worker-auth"
#   aead_type = "aes-gcm"
#   key = ""
#   key_id = "global_worker-auth"
# }

# Recovery KMS block: configures the recovery key for Boundary
# Use a production KMS such as AWS KMS for production installs
kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = ""
  key_id = "global_recovery"
}

# Events (logging) configuration. This
# configures logging for ALL events to both
# stderr and a file at /var/log/boundary/controller.log
events {
  audit_enabled       = true
  sysevents_enabled   = true
  observations_enable = true

  sink "stderr" {
    name = "all-events"
    description = "All events sent to stderr"
    event_types = ["*"]
    format = "cloudevents-json"
  }

  sink {
    name = "file-sink"
    description = "All events sent to a file"
    event_types = ["*"]
    format = "cloudevents-json"

    file {
      path = "./logs"
      file_name = "controller.log"
    }

    audit_config {
      audit_filter_overrides {
        sensitive = "redact"
        secret    = "redact"
      }
    }
  }
}

# Logging configuration
log_level = "debug"

# Telemetry configuration
telemetry {
  enabled = false
  prometheus_retention_time = "24h"
  disable_hostname          = true
}
