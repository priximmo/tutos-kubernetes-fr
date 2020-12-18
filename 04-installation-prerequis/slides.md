%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Kubernetes : Prérequis <-


<br>

* Recommandations :

```
2 Gb ram
2 CPU
ouverture réseau large entre les 2 machines
Ports master : 6443 2379-2380 10250 10251 10252
Ports node : 10250 30000-32767
pas de swap
```

<br>

* prérequis : installation de docker

```
curl -fsSL https://get.docker.com | sh;
sudo usermod -aG docker $USER

groupadd -g 500000 dockremap && 
groupadd -g 501000 dockremap-user && 
useradd -u 500000 -g dockremap -s /bin/false dockremap && 
useradd -u 501000 -g dockremap-user -s /bin/false dockremap-user

echo "dockremap:500000:65536" >> /etc/subuid && 
echo "dockremap:500000:65536" >>/etc/subgid

echo "
  {
   \"userns-remap\": \"default\"
  }
" > /etc/docker/daemon.json

systemctl daemon-reload && systemctl restart docker

```

--------------------------------------------------------------------------------------------

-> Kubernetes : installation  <-

* désactivation du swap

<br>

```
swapoff -a
vim /etc/fstab
```

<br>

* mise en place du dépôt apt :

```
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
```

<br>

* installation des binaires kubernetes :

```
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
systemctl enable kubelet
```

	- kubeadm : installation du cluster
	- kubelet : service qui tourne sur les machines (lancement pods...)
	- kubectl : permet la communication avec le cluster


