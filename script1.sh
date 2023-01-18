#!/bin/sh
#run this on ALL HOSTS

yum install epel-release -y
yum install open-vm-tools -y
yum check-update
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
rm -f /etc/containerd/config.toml
systemctl enable docker
systemctl start docker
systemctl enable containerd
systemctl start containerd
echo “192.168.1.20 master” >> /etc/hosts
echo “192.168.1.21 worker-01” >> /etc/hosts
echo “192.168.1.22 worker-02” >> /etc/hosts
echo “192.168.1.23 worker-03”  >> /etc/hosts
cat /etc/hosts
docker run hello-world
wget https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/kubernetes.repo  -O /etc/yum.repos.d/kubernetes.repo 
yum install -y kubelet
yum install -y kubeadm
 systemctl disable firewalld
 systemctl stop firewalld
wget https://raw.githubusercontent.com/flinty1970/Kubernetes_Lab/main/k8s.conf -O /etc/sysctl.d/k8s.conf
sysctl --system
 systemctl enable kubelet.service 
 systemctl start kubelet.service
sed -i '/swap/d' /etc/fstab
 swapoff -a
