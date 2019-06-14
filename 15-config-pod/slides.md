%title: Kubernetes 
%author: xavki

# Pods

## Principes

<br>
* permettre de lancer les conteneurs docker

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


## Configuration minimum


```
# Version api k8s
apiVersion: v1
# Type de ressource
kind: Pod
# Metadata spec ressource
metadata:
  name: monpod
# Spécifications liées à la ressource
spec:
  containers:
  - name: nginx
    image: nginx
```


--------------------------------------------------------------------------


## Configuration : namespace et ports


* Exposition des ports du containeurs et cloisonnement :

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
  # définition du namespace
  namespace: xavki
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```


--------------------------------------------------------------------------

## Configuration : politique de restart


* idem docker

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
  namespace: xavki
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  restartPolicy: Always
```


--------------------------------------------------------------------------

## Configuration : commande à exécuter



```
apiVersion: v1
kind: Pod
metadata:
  name: hello
  namespace: xavki
spec:
  containers:
  - name: monalpine
    image: alpine
    command: ["echo", "hello"]
```


--------------------------------------------------------------------------

## Configuration : politique de restart


* idem docker











