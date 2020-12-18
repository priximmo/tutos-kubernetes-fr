%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# K3S : cluster kub pour faibles ressources


<br>

* k8s = beaucoup de ressources

* pb pour :
	* IoT
	* CI/CD
	* ARM

* k3s => rancher

* k3s = containerd

* https://rancher.com/docs/k3s/latest/en/installation/installation-requirements/
	* 1 CPU
	* 512 MB

Attention : c'est hors HA (externalisation de la BDD)

--------------------------------------------------------------------------------------

# K3S : cluster kub pour faibles ressources



<br>

Comment ?

* base de données sqlite (à la place de ETCD)

* sans versions alpha ou beta

* rétrocompatibilité

* on y  retrouve :
	* coredns
	* metrics-server
	* helm
	* traefik


--------------------------------------------------------------------------------------

# K3S : cluster kub pour faibles ressources


<br>

* installation 

```
curl -sfL https://get.k3s.io | sh -
yum install -y container-selinux selinux-policy-base
rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm
```

<br>

* flannel

```
ExecStart=/usr/local/bin/k3s \
    server \
    --flannel-iface 'eth1'
```

```
sudo systemctl daemon-reload
sudo systemctl restart k3s
```

--------------------------------------------------------


# K3S : cluster kub pour faibles ressources


<br>

* installation de kubectl

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

<br>

* certificat

```
/etc/rancher/k3s/k3s.yaml
```

<br>

* modification des droits

```
chmod 644 /etc/rancher/k3s/k3s.yaml
```

* premier kubectl 

```
kubectl get nodes

--kubeconfig=/etc/rancher/k3s/k3s.yaml

ou run avec --write-kubeconfig-mode
```
