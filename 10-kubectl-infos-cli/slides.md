%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Kubernetes : recueillir de l'information <-


<br>

* liste des noeuds et leurs états:

```
kubectl get nodes
kubectl describe nodes kubmaster
```

<br>

* les composants

```
kubectl get componentstatuses
kubectl get daemonsets -n kube-system
```

---------------------------------------------------

-> Pods et services <-

<br>

* liste des pods

```
kubectl get pods
```

<br>

* liste des services

```
kubectl get services
```

<br>

* lister les dépoiements

```
kubectl get deploy
```

<br>

* pour tout lister

```
kubectl get all
```

<br>

* options récurrentes

```
-o wide : plus d'infos

-n kube-system : afficahge des infos du système (namespace système)
```

----------------------------------------------------------------------------


-> Kubernetes : logs, events et describe <-


<br>

* describe : afficher la configuration

```
kubectl describe nodes

kubectl describe pods nginx...

kubectl describe service nginx 

kubectl describe deploy nginx
```

<br>

* logs : pour afficher les logs de chaque pods

```
kubectl logs nginx...
```

<br>

* events : lister les évènements liés aux pods

```
kubectl get events nginx...
```



