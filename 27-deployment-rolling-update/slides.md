%title: Kubernetes 
%author: xavki

# Deployment : c'est de la magie !!!


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

* test continu 

```
while true;do curl -s 10.99.29.169 >/dev/null; echo 1;done
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

