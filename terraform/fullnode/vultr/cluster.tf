resource "vultr_kubernetes" "k8" {
  region  = var.fullnode_region
  label   = "aptos-devnet"
  version = "v1.23.5+3"

  node_pools {
    node_quantity = var.num_fullnodes
    plan          = var.machine_type
    label         = "aptos-fullnode"
  }
}

resource "local_file" "kube_config" {
  content  = base64decode(vultr_kubernetes.k8.kube_config)
  filename = "${path.module}/vultr_kube_config.yml"
}