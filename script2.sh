#!/bin/sh
# script to setup Kubernetes Master
kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/
sleep 5
kubectl get nodes
kubectl get pods --all-namespaces
