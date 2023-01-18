#!/bin/sh
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl create -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
sleep 30
kubectl create -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/metallb2.yaml
kubectl create -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/metallb.yaml
sleep 60
kubectl get pods --all-namespaces
