%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# ConfigMaps et Secrets : création et mise à jour


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

* attention sécurité : les secrets peuvent être manipulés en manifeste 


-------------------------------------------------------------------------------------------------------

# ConfigMaps et Secrets : les variables


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

* multiples variables pour un même configMap :

```
kubectl create configmap langue --from-literal=LANGUAGE=Fr --from-literal=ENCODING=UTF-8
kubectl get configmaps
```


------------------------------------------------------------------------------------------------------


# ConfigMaps et Secrets : les fichiers



```
kubectl create configmap maconfiguration --from-file=maconf.cfg
kubectl get configmaps
```


-----------------------------------------------------------------------------------------------------

# ConfigMaps et Secrets : mises à jour


3 méthodes :

<br>

* création d'un fichier manifeste et exécution

```
kubectl replace -f manifeste.yml
```
Rq : problème de la sécurité du contenu
redémarrage pour prise en compte


<br>

* édition du configMap

```
kubectl edit configmap monconfigmap
```

Rq :pas de redémarrage pour prise en compte


<br>

* génération à blanc et remplacement
```
kubectl create configmap maconf --from-literal=LANGUAGE=Es -o yaml --dry-run | kubectl replace -f -
```

Rq : redémarrage nécessaire
