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

* attention sécurité : les secrets peuvent être manipulés en manifeste 


-----------------------------------------------------------------------------

# ConfigMaps et Secrets : création


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
* update ? 3 méthodes

```
kubectl create configmap maconf --from-literal=LANGUAGE=Es -o yaml --dry-run | kubectl replace -f -
```

<br>
* puis recréer le pod en le supprimant 

-------------------------------------------------------------------------------------------------------

# ConfigMaps et Secrets : utilisation dans un pod


<br>
* variable d'environnement :


```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /usr/share/nginx/html/index.html
      name: monvolumeconfig
  env:
    - name: mavariable
      valueFrom: 
        configmapkeyref:
        - name: monconfigmap
          key: mavariable
```


-------------------------------------------------------------------------------------------------------

# ConfigMaps et Secrets : utilisation dans un pod


<br>
* fichier monté en volume

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /usr/share/nginx/html/index.html
      name: monvolumeconfig
  volumes:
  - name: monvolumeconfig
    configMap:
      name: monconfigmap
```

Rq : monter plusieurs fichiers dans le même configMap et ajouter le volume en répertoire


-------------------------------------------------------------------------------------------------------


# ConfigMaps et Secrets : utilisation dans un pod


