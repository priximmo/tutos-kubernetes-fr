%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Deployment : c'est de la magie !!!


<br>

* voir plus large : pods, replicaset > déploiement


<br>

* penser aux montées de versions : progressivité, itérations, stratégie


* penser aux rollbacks en cas d'imprévus


* un outil unique


---------------------------------------------------------------------------------------

# Différents types de déploiements


<br>

* 2 proposés par kubernetes :
		- rolling update : ex - 3 pods v1.0
						- 1. création d'un pod v2.0
						- 2. intégration de v2.0 dans pool si conforme
						- 3. suppression d'un pod v1.0
						- etc
		- recreate : plus violent
						- suppression des v1.0
						- création des v2.0

* ajout de 2 autres grâce à d'autres outils :
		- blue/green : coexistence des 2 versions dont la nouvelle pour test
		- canary deployment : coexistence des 2 mais migration des requêtes progressive

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
    type: recreate				# type
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

