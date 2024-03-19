Introduce

Note dùng để tóm tắt kinh nghiệm với k8s

* Những helm chart thường sử dụng (Fluentbit, grafana, prometheus)
* Command, cách dựng k8s, tip vs k8s
## INSTALL K8S
- Turn of swap
- enable iptable bridge
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```
- Install CRI-O Runtime On All The Nodes
```
OS="xUbuntu_22.04"
  

VERSION="1.28"

cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /
EOF
cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /
EOF
```
```
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -
```
```
sudo apt-get update
sudo apt-get install cri-o cri-o-runc cri-tools -y
sudo systemctl daemon-reload
sudo systemctl enable crio --now
```
- Install Kubeadm & Kubelet & Kubectl on all Nodes
```
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
```
```
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
```
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```
```
sudo apt-get update -y
sudo apt update
apt-cache madison kubeadm | tac
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
```
local_ip=10.20.23.197
cat > /etc/default/kubelet << EOF
KUBELET_EXTRA_ARGS=--node-ip=$local_ip
EOF
```
- Initialize Kubeadm On Master Node To Setup Control Plane
```
IPADDR="x.x.x.x"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"
```
```
sudo kubeadm init --apiserver-advertise-address=$IPADDR  --apiserver-cert-extra-sans=$IPADDR  --pod-network-cidr=$POD_CIDR --node-name $NODENAME --ignore-preflight-errors Swap
```
- install pod network ("calico)
```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml

curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml -O

kubectl create -f custom-resources.yaml
```
- if error
```
        - 'systemctl status kubelet'
        - 'journalctl -xeu kubelet'
```
## INSTALL MetalLB
- deploy metallb
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml
```
- config IP for metallb
```
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
    - 192.168.1.50/32
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
    - default-pool
```
```
kubectl apply -f config.yaml
```
- deploy nginx
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.7.0/deploy/static/provider/cloud/deploy.yaml
```
-  router cấu hình mở port 80/443 và forward traffic đến IP 192.168.1.50 hoặc có thể thêm IP 192.168.1.50 vào DMZ zone.
## INSTALL METRICS SERVER
```
kubectl apply -f https://raw.githubusercontent.com/techiescamp/kubeadm-scripts/main/manifests/metrics-server.yaml
kubectl top nodes
```
## INSTALL NFS SERVER (ubuntu)
- install nfs server
```
sudo apt-get update
sudo apt install nfs-kernel-server
```
- create export directory
```
mkdir -p /data
sudo chown -R nobody:nogroup /data
sudo chmod -R 777 /data
```
- grant client machine access nfs server
```
sudo nano /etc/exports
/data clientIP(rw,sync,no_subtree_check)
/data 192.168.0.0/24(rw,sync,no_subtree_check)
```
- apply the config
```
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```
- check again
```
showmount -e 192.168.10.19
```
- install nfs-client (Cần phải cài đặt NFS Client trên tất cả các worker node để khi tạo Pod trên node đó có sử dụng NFS Storage Class thì node đó có thể mount được phân vùng NFS đã được share bởi NFS Server.)
```
sudo apt update
sudo apt install nfs-common
```
- if status nfs-common 
```
○ nfs-common.service
     Loaded: masked (Reason: Unit nfs-common.service is masked.)
     Active: inactive (dead)

```
- => fix it
```
rm /lib/systemd/system/nfs-common.service
systemctl daemon-reload
sudo systemctl start nfs-common
sudo systemctl status nfs-common
```
- creating mount point and 10.20.23.187
```
sudo mount 10.20.23.187:/media/rk-svdg1/DATA/retain /nfs/retain
sudo mount 10.20.23.187:/media/rk-svdg1/DATA/delete /nfs/delete
```
- auto connect nsf-server when start. Edit file 
```
sudo nano /etc/fstab
10.20.23.187:/media/rk-svdg1/DATA/retain    /nfs/retain   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
10.20.23.187:/media/rk-svdg1/DATA/delete   /nfs/delete   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
```
## DEPLOY NEXUS
