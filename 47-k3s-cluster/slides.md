%title: Kubernetes 
%author: xavki


# K3S : cluster kub pour faibles ressources


<br>
* ajout d'un noeud

```
yum install -y container-selinux selinux-policy-base
rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm
curl -sfL https://get.k3s.io | K3S_TOKEN=<ip> K3S_URL=https://<ip>:6443 sh -
```

<br>
* flannel

```
sudo vim /etc/systemd/system/k3s-agent.service
ExecStart=/usr/local/bin/k3s \
    agent \
    --flannel-iface 'eth1'
```

```
sudo systemctl daemon-reload
sudo systemctl restart k3s-agent
```
