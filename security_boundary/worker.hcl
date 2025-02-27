# disable memory from being swapped to disk
disable_mlock = true

# Proxy listener configuration block
listener "tcp" {
  # The purpose of this listener block
  purpose = "proxy"

  # Should be the address of the NIC that the controller server will be reached on
  # Use 0.0.0.0 to listen on all interfaces
  address = "0.0.0.0:9202"

  # TLS Configuration
  tls_disable = true
  # tls_cert_file = "/etc/boundary.d/tls/boundary-cert.pem"
  # tls_key_file  = "/etc/boundary.d/tls/boundary-key.pem"
}

worker {
  # name = "homelab-worker"
  # description = "HomeLab Worker Instance"

  # address = "0.0.0.0"
  # public_addr = "127.0.0.1"
  # public_cluster_addr = "localhost"

  # Workers typically need to reach upstreams on :9201
  initial_upstreams = ["192.168.50.50"]
  # controllers = ["192.168.50.50"]
  # build value with command "boundary workers create controller-led"
  controller_generated_activation_token = ""

  auth_storage_path = "./worker"
  recording_storage_path = "./recording"
  recording_storage_minimum_available_capacity = "100MB"

  tls_disable   = true

  tags {
    type = "homelab_worker",
    os = "linux"
  }
}

kms "aead" {
    purpose = "root"
    aead_type = "aes-gcm"
    key = ""
    key_id = "global-root"
}

kms "aead" {
    purpose = "recovery"
    aead_type = "aes-gcm"
    key = ""
    key_id = "global-recovery"
}

kms "aead" {
  purpose = "worker-auth-storage"
    aead_type = "aes-gcm"
    key = ""
    key_id = "global-worker-auth-storage"
}

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
      file_name = "worker.log"
    }

    audit_config {
      audit_filter_overrides {
        sensitive = "redact"
        secret    = "redact"
      }
    }
  }
}
