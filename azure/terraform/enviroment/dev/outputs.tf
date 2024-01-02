output "host" {
    value = module.aks.kube_config.0.host
}
output "name" {
    value = module.aks.name
}
output "client_certificate" {
    value = module.aks.kube_config.0.client_certificate
}
output "client_key" {
    value = module.aks.kube_config.0.client_key
}
output "cluster_ca_certificate" {
    value = module.aks.kube_config.0.cluster_ca_certificate
}
output "kube_config_raw" {
    value = module.aks.kube_config_raw
}
output "kube_config" {
    value = module.aks.kube_config_raw
}
output "resource_group_name" {
    value = module.aks.resource_group_name
}
output "location" {
    value = module.aks.location
}
output "dns_prefix" {
    value = module.aks.dns_prefix
}
output "fqdn" {
    value = module.aks.fqdn
}
