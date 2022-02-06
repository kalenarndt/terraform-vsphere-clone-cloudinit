#!/bin/bash
# Basic example of adding a repo and installing Vault Enterprise in a VM.
set -v
echo '> Adding HashiCorp Linux Repository'
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo '> Installing Vault Enterprise'
apt install -y vault-enterprise

# Set Vault License
echo '> Creating Vault Enterprise License File'
tee /opt/vault.d/vault.hclic >/dev/null <<EOL
${vault_license}
EOL


tee /opt/vault.d/vault.hclic >/dev/null <<EOL
cat << EOF > /etc/vault.d/vault.hcl
disable_performance_standby = true
ui = true
disable_mlock = true
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "$instance_name"
  retry_join {
    auto_join = retry_join = ["provider=vsphere category_name=HashiCorp-Servers tag_name=Consul-Server host=172.23.1.5 user=cloud-auto-join@vsphere.local password=pqx4WUN9tzf7jhk-ecu insecure_ssl=true"]
  }
}

cluster_addr = "http://{{ GetInterfaceIP \"ens192\" }}:8201"
api_addr = "http://{{ GetInterfaceIP \"ens192\" }}:8200"
listener "tcp" {
  address            = "0.0.0.0:8200"
  tls_disable        = true
}

seal "azurekeyvault" {
  tenant_id = "${tenant_id}"
  vault_name = "${key_vault_name}"
  key_name = "${key_vault_key_name}"
}

license_path = "/opt/vault/vault.hclic"
EOL


echo '> Done!'
