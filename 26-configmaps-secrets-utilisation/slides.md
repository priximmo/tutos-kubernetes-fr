%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# ConfigMaps et Secrets : utilisation


<br>


* création par la ligne de commande - CLI

<br>


* possibilité de créer par manifeste


<br>


```
kind: ConfigMap 
apiVersion: v1 
metadata:
  name: personne
data:
  nom: Xavier 
  passion: blogging
  clef: |
 
    age.key=40 
    taille.key=180
```

<br>

* 2 types :
		- volumes
		- configMapKeyRef


-----------------------------------------------------------------

# Utilisations : en variables


<br>


* variables env : configMapKeyRef

<br>


* une à une :

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env:
        - name: NOM
          valueFrom:
            configMapKeyRef:
              name: personne
              key: nom
        - name: PASSION
          valueFrom:
            configMapKeyRef:
              name: personne
              key: passion
```

-------------------------------------------------------------------

# Utilisations : configMapKeyRef


<br>


* toute la configmap

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
    - name: test-container
      image: busybox
      command: [ "/bin/sh", "-c", "env" ]
      envFrom:
        - configMapRef:
            name: personne
```

-------------------------------------------------------------------

# ConfigMaps et Secrets : en volumes


<br>

* fichiers ou répertoires


<br>


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

