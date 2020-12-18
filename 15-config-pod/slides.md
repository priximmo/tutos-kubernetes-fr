%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Pods

## Principes

<br>

* permettre de lancer les conteneurs docker

* manifeste : configuration en mode déclaratif
	- format yaml ou json

<br>

* à éviter : 
		- préférer les déploiements (plus aboutis)
		- k8s n'a pas d'intérêts (pas de persistence)

<br>

* deux types de pods :
		- mono conteneurs
		- multi-conteneurs

<br>

* pods répliqués = un groupe nommé controller :
		- deployment
		- statefulset
		- daemonset

* ces controllers utilisent des templates de pods

<br>

* les conteneurs d'un même pods possède : 
		- le même réseau (ip/port)
		- les mêmes volumes

* communication par localhost

<br>

* doc k8s : https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.14/#pod-v1-core

---------------------------------------------------------------------------


# Configuration minimum

* Version api k8s
* Type de ressource : pod, deployment, replicaset, service
* metadata : information sur la ressource créée
* spec : caractéristiques spécifiques de la ressource

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: nginx
    image: nginx
```


--------------------------------------------------------------------------


# Configuration : namespace, labels, annotations


<br>

* namespace, labels, annotations : cf vidéos précédentes

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
  # définition du namespace
  namespace: xavki
  # labels
  labels:
    env: prod
spec:
  containers:
  - name: nginx
    image: nginx
```


--------------------------------------------------------------------------

## Exposition de ports

* attention : exposition interne uniquement (sinon services)

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
```

-------------------------------------------------------------------------

## Pods multiconteneurs

<br>

```
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  - name: mondebian
    image: debian
    command: ["sleep", "600"]
```
<br>

Connexion à un des conteneurs 

```
kubectl exec -ti monpod -c mondebian /bin/bash
```

