#!/bin/sh

echo Install Calico network
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/tigera-operator.yaml
sleep 10

echo Install Calico network 2
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/custom-resources.yaml

echo wait 3 mins....
sleep 180

echo StaticARP
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
sleep 20

echo Install MetalLB
kubectl create -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
sleep 60

echo Configure MetalLB 1
kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/metallb.yaml

echo Configure MetalLB 2
kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/metallb2.yaml

exit 0
