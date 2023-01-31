#!/bin/sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml
echo Getting IP of nginx ingress controller:
kubectl -n ingress-nginx get svc ingress-nginx-controller 
kubectl create namespace dev

for NS in `kubectl get ns --no-headers| awk '{ print $1 }'`
do 
  kubectl patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"image-pull-secret\"}]}" -n $NS
done

kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/hello-app.yaml
kubectl get deployments -n dev
kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/hello-app-service.yaml 
kubectl apply -f https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/hello-app-ingress.yaml 
kubectl describe ingress  -n dev
