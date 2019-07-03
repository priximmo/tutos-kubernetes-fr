%title: Kubernetes 
%author: xavki

# ConfigMaps et Secrets


<br>
* centraliser, améliorer et faciliter la gestion des configurations

<br>
* etcd, consul / vault...

<br>
* stocker les fichiers de configuration :
		- les isoler
		- les sécuriser
		- les manipuler 
		- les partager (entre pods)

<br>
* amélioration des config-file de docker/dockerfile
		- reconstruction des images

* secrets = configmaps avec encoding en base 64


-----------------------------------------------------------------------------

# ConfigMaps et Secrets


<br>
* exemple configmaps en CLI :

```
kubectl create configmap langue --from-literal=LANGUAGE=Fr
kubectl get configmaps
```

<br>
* exemple configmaps en CLI :

```
kubectl create secret generic mysql_password --from-literal=MYSQL_PASSWORD=monmotdepasse
kubectl get configmap
```

<br>
* update ?

```
kubectl create configmap maconf --from-literal=LANGUAGE=Es -o yaml --dry-run | kubectl replace -f -
```

<br>
* puis recréer le pod en le supprimant 



