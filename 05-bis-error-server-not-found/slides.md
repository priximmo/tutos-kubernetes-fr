%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Bug sur Vagrant / VirtualBox <-

<br>

* flannel : pods network

<br>

* prend pas l'ip de eth1

<br>

* diagnostiquer

```
kubectl get nodes -o wide
```

Vérifier INTERNAL_IP => si la même et pas le bon réseau


------------------------------------------------------------

-> Corriger ? sans réinstaller <-


<br>

* modifier /etc/hosts sur le master et les noeuds

<br>

* ajouter ip suivi du nom de la machine dans kub
sur tous les noeuds

```
192.168.99.100 kubmaster
```

<br>

* puis supprimer les pods flannel

* ils vont se reconstruire en prenant en compte la modification

```
kubectl get pods -n kube-system

kubectl delete pods flannel-xxx -n kybe-system
```
Autant de fois que de pods

<br>

* Vérifier

```
kubectl get nodes -o wide
```


