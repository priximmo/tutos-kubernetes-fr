%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Kubernetes : shell interactif <-


<br>


* parallèle avec docker : 
		- run : lancement d'un deployement en ligne de commande (lancera un pod)
		- exec : permet d'éxécuter une commande dans un pod ou se connecter en bash

<br>

* lancement de 2 pods :

```
kubectl run myshell -it --image busybox -- sh

kubectl run anothershell -it --image busybox -- sh
```
-----------------------------------------------------------------------------------------------

-> Que s'est-il passé ? <-


<br>

* consulter les conteneurs docker :

```
docker ps | grep "myshell\|another"
```

<br>

* consulter les images docker :

```
docker images | grep busybox
```

<br>

* supprimer pods

```
kubectl delete deployment myshell

kubectl delete deployment anothershell
```

<br>

* possiblité d'utiliser --rm :

```
kubectl run --rm -it myshell --image busybox -- sh
```


