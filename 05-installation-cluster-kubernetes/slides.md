%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Kubernetes : initialisation et join <-


<br>

* initilisation sur le master


```
kubeadm init --apiserver-advertise-address=192.168.56.101  
--node-name $HOSTNAME --pod-network-cidr=10.244.0.0/16
```

Rq :édition du host nécessaire sur Vbox et Vagrant

<br>

* création du fichier de configuration

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---------------------------------------------------------------------


-> Mise en place du réseau interne : choix de flannel <-


<br>

* ajout pod pour gestion du réseau interne

```
sysctl net.bridge.bridge-nf-call-iptables=1

kubectl apply -f 
https://raw.githubusercontent.com/coreos/flannel/
a70459be0084506e4ec919aa1c114638878db11b/Documentation/kube-flannel.yml

# si nécessaire
kubectl edit cm -n kube-system kube-flannel-cfg
# edit network 10.244.0.0/16 to 10.10.0.0/16 pour dashboard
```



-------------------------------------------------------------------------------------------


-> Kubernetes : join <-



* on vérifie l'état des pods system :

```
kubectl get pods --all-namespace
kubectl get nodes
```

<br>

* on fait le join sur le node :

```
kubeadm join 192.168.56.101:6443 --token 5q8bsc.141bc9wjsc026u6w 
--discovery-token-ca-cert-hash sha256:e0f57e3f3055bfe4330d9e93cbd8de967dde4e4a0963f324d2fe0ccf8427fcfb
```

<br>

* on vérifie l'état des pods system :

```
kubectl get pods --all-namespace
kubectl get nodes
```

