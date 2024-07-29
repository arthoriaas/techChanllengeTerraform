# For authentication, the Helm provider can get its configuration by supplying a path to your kubeconfig file.
#provider "helm" {
#  kubernetes {
#    config_path = "~/.kube/config"
#    }
#	}
#
# Used to interact with the resources supported by Kubernetes.
# The provider needs to be configured with the proper credentials before it can be used.
#provider "kubernetes" {
#  config_path = pathexpand(var.kube_config)
#}

#variable "kube_config" {
#  type    = string
#  default = "~/.kube/config"
#}
#
#resource "helm_release" "kube-prometheus" {
#  name       = "kube-prometheus-stackr"
#  namespace  = var.namespace
#  version    = var.kube-version
#  repository = "https://prometheus-community.github.io/helm-charts"
#  chart      = "kube-prometheus-stack"
#}
#
#resource "kubernetes_namespace" "monitoring" {
#  metadata {
#    name = var.namespace
#  }
#}
#variable "namespace" {
#  type    = string
#  default = "monitoring"
#}
#variable "kube-version" {
#}

