%title: Kubernetes 
%author: xavki

# ConfigMaps et Secrets

```

kind: ConfigMap
apiVersion: v1
metadata:
  name: personne
data:
  clef: |
    Bonjour
    les
    Xavkistes !!!
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
    - mountPath: /usr/share/nginx/html/
      name: monvolumeconfig
  volumes:
  - name: monvolumeconfig
    configMap:
      name: personne
      items:
      - key: clef
        path: index.html
```


-------------------------------------------------------------------------------------------------------

# ConfigMaps et Secrets : répertoire


<br>
* création

```
kubectl create configmap mondir --from-file=index.html --from-file=monfichier.html
```

* pod

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
    - mountPath: /usr/share/nginx/html/
      name: mondir
  volumes:
  - name: mondir
    configMap:
      name: mondir
```
