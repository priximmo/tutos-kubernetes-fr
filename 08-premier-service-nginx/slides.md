%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Kubernetes : premier pod / service <-


<br>

* pod = entité de référence dans kub : un ou plusieurs conteneurs docker

* deployment = c'est une représentation logique de un ou plusieurs pod (configuration)

* service = moyen d'accéder à nos pods (ip/port)

<br>

* création de pod sans fichier de conf ou avec

<br>

* commande :

```
kubectl create deployment monnginx --image nginx
```

<br>

* visulisation de deployments et pods :

```
kubectl get deployments
kubectl get pods
```

* détails :

```
kubectl describe deployment nginx
```

---------------------------------------------------------------------------------------


-> Exposition du pods : service <-

<br>

* Comment accéder au nginx ?

<br>

* service = moyen d'accès à nos pods

```
kubectl create service nodeport monnginx --tcp=8080:80
```

* méthode :
nodeport = exposition de port : rendre public notre pod via un port (30000-32767)
Clusterip = minimale car exposition interne
loadBalancerIP = pour exposer via controler ingress ou dans le cloud
externalname = via url

Infos : https://kubernetes.io/docs/concepts/services-networking/

-------------------------------------------------------------------------------------


-> Autre méthode expose deployment <-



```
kubectl expose deployment nginx --type NodePort --port 80
```


* ponctuellement et non recommandé le port-forwarding

```
kubectl port-forward nginx-5c7588df-kj2pn 8080:80
```
