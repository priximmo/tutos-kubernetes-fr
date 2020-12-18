%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# ReplicaSet : dupliquer vos pods


<br>

* créer des réplicas de pods

* préférer la ressource deployment (plus récente et plus large)

* ne pas confondre avec du scaling : nombre d'instance fixe

<br>

* 2 manières :
		- attachée aux pods
		- détachée des pods

<br>

* attaché :
		- template de pods
		- au sein du même fichier

<br>

* détaché :
		- création de pods puis d'un replicaset
		- selector pour sélectionner les pods ciblés


------------------------------------------------------------------------


# Squelette


<br>

```
apiVersion: apps/v1
kind: replicaSet		# set ressources
metadata: 					# metadata spécifiques au replicaset

spec:								# conf du réplicaset

	replicas: 2				# nombre de replicas

	selector:					# utilisation de la sélection
    matchLabels:		# sélection sur les labels
			lab1: toto		# filtre

  template:					# caractéristiques du template de pods
    metadata:				# metadata des pods créés
      labels:				# définition des labels
        lab1: toto  # création du label qui va matcher
    spec: 					# spec des pods
			...
```


------------------------------------------------------------------------

# Exemple


* nginx

<br>

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: front
  labels:
    app: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: mynginx
        image: nginx
```

------------------------------------------------------------------------


# Informations sur le ReplicaSet


<br>

* liste des RS

```
kubect get rs
```

<br>

* métas du RS

```
kubectl describe rs front
```

<br>

* manifeste d'un pod

```
kubectl get pods frontend.. -o yaml
```

------------------------------------------------------------------------


# Replicaset : appariement de Pod


<br>

* création d'un pod seul

```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    env: prod
    type: front
spec:
  containers:
  - name: nginx
    image: nginx
```

-------------------------------------------------------------------------


# Replicaset : appariement de Pod


<br>

* création du replicaset

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: front2
  labels:
    app: front
spec:
  replicas: 3
  selector:
    matchLabels:
      type: front
      env: prod
  template:
    metadata:
      labels:
        type: front
        env: prod
    spec:
      containers:
      - name: nginx
        image: nginx
```

