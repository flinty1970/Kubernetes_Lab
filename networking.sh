#!/bin/sh

echo Install Calico network
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/tigera-operator.yaml
echo Install Calico network 2
kubectl create -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/calico-cr.yaml
#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/custom-resources.yaml

sleep 20
loop=1
while [ $loop -ne 0 ]
do
  loop=`kubectl get pods -A --no-headers | grep -v Running| grep -v coredns |sort| uniq | wc -l`
  sleep 1
done

echo StaticARP
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system

echo Install MetalLB
kubectl create -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

loop=1
while [ $loop -ne 0 ]
do
  loop=`kubectl get pods -A --no-headers | grep -v Running| grep -v coredns |sort| uniq | wc -l`
  sleep 1
done

echo Configure MetalLB 1
kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/metallb.yaml

loop=1
while [ $loop -ne 0 ]
do
  loop=`kubectl get pods -A --no-headers | grep -v Running| grep -v coredns |sort| uniq | wc -l`
  sleep 1
done

echo Configure MetalLB 2
kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/metallb2.yaml

exit 0
