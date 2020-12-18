%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Deployment : Rolling Update - partie 1


<br>

* 2 types de déploiements pour des montées de version :
		- rolling update
    - recreate


<br>

* penser aux montées de versions : progressivité, itérations


* penser aux rollbacks en cas d'imprévus


------------------------------------------------------------------------

# Exemple : notre bon vieux nginx

* avec readiness (si pb sotie du pool)

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myfirstdeploy
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: monfront
  template:
    metadata:
      labels:
        app: monfront
    spec:
      containers:
      - image: nginx:1.16			 # suivante 1.17
        imagePullPolicy: Always
        name: podfront
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
             path: /
             port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
          successThreshold: 1
```

------------------------------------------------------------------------

# Exposition via le service

* exposition via un service

```
apiVersion: v1
kind: Service
metadata:
  name: myfirstdeploy
spec:
  clusterIP: 10.99.29.169
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: monfront
  type: ClusterIP
```


------------------------------------------------------------------------

# Montée de version


```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myfirstdeploy
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: monfront
  template:
    metadata:
      labels:
        app: monfront
    spec:
      containers:
      - image: nginx:1.17    
        imagePullPolicy: Always
        name: podfront
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
             path: /
             port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
          successThreshold: 1
```

-------------------------------------------------------------------------

# Avec rolling update


<br>

```
  strategy:
    type: RollingUpdate				# type
    rollingUpdate:						# définition
      maxSurge: 2							# nb pods sup autorisé
      maxUnavailable: 0				# nb de pods down autorisés
```

<br>

Exemple :
		- on autorise pas de réduction de nombre de pods
					- maxUnavailable = 0
		- on peut déborder de 2 pods
					- maxSurge = 2

<br>

En plus : 
		- minReadySeconds : délai pour lancer un autre update de pod
		- progressDeadlineSeconds : délai max pour le déploiement sinon fail
		- revisionHistoryLimit : nombre d'historiques en mémoire

-------------------------------------------------------------------------

# Avec rolling update

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myfirstdeploy
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: monfront
  strategy:
    type: RollingUpdate				# type
    rollingUpdate:						# définition
      maxSurge: 2							# nb pods sup autorisé
      maxUnavailable: 0				# nb de pods down autorisés
  template:
    metadata:
      labels:
        app: monfront
    spec:
      containers:
      - image: nginx:1.16
        imagePullPolicy: Always
        name: podfront
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
             path: /
             port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
          successThreshold: 1
```

