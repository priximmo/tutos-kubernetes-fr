%title: Kubernetes 
%author: xavki

# Deployment : en avant la musique


<br>
* voir plus large : pods, replicaset et déploiement


<br>
* penser aux montées de versions : progressivité, itérations


* penser aux rollbacks en cas d'imprévus


* un outil unique

<br>
* principe de rolling update / rolling release
		- mise à jour progressive de chacune des instances avec vérifications continues



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
      maxSurge: 1							# nb pods
      maxUnavailable: 1				# nb erreurs autorisées
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

