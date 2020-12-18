%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Deployment : Rolling Update - partie 2


<br>

* gérer le versionning des déploiements

<br>

* permettre un retour arrière rapide
		- sans fichier à éditer

<br>

* utilisation des annotations 

```
spec:
  template:
    metadata:
      annotations:
        kubernetes.io/change-cause: "Mise à jour version 1.16"
```



------------------------------------------------------------------------------------


<br>


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


---------------------------------------------------------------------------------------


# Commandes rollout


<br>

* état du déploiement

```
kubectl rollout status deployments <nom>
```

<br>

* mettre en pause

```
kubectl rollout pause deployments <nom>
```

* reprise

```
kubectl rollout resume deployments <nom>
```

<br>

* historique

```
kubectl rollout history deployments <nom>
kubectl rollout history deployments <nom> --revision=3
```

<br>

* surtout le retour arrière

```
kubectl rollout undo deployments <nom>
kubectl rollout undo deployments <nom> --to-revision=2
```

Rq : revisionHistoryLimit dans les spec de deployment
