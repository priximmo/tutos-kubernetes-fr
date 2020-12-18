%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# Labels et Annotations

<br>

## Principe

* démo en CLI

* s'applique aux ressources

<br>

* labels : utilisés par kubernetes (selectors)

* annotations : utilisés en dehors de kubernetes

<br>

* affectation de labels :

```
kubectl run monnginx --image nginx --labels "env=prod,group=front"
kubectl run monnginx2 --image nginx --labels "env=devel,group=front"
```

<br>

* affichage des labels :

```
kubectl get pods --show-labels
```

<br>

* update d'un label :

```
kubectl label pods monnginx2-5d7c66c95d-qj27m --overwrite "group=back"
```

-----------------------------------------------------------------------------

## Suppression et utilisation


<br>

* suppression d'un label :

```
kubectl label pods monnginx2-5d7c66c95d-qj27m --overwrite "group-"
```

<br>

* selection (selectors):

```
kubectl get pods --selector "env=devel" --show-label
```

Rq : possiblité d'utiliser des opérateurs
 --selector "env in (devel,prod)"

<br>

## Annotations


* exactement le même fonctionnement mais avec "annotations"


* permet :
	- garder des traces
	- stocker des fichiers (ex : images en base 64)
	- des liens/url



