#!/bin/sh
yum install nfs-utils -y
systemctl enable --now nfs-server
systemctl enable --now rpcbind
systemctl start  nfs-server
systemctl start rpcbind
mkdir -p /export/kubernetes
echo '/export/kubernetes *(rw,no_root_squash)' > /etc/exports
exportfs -a
