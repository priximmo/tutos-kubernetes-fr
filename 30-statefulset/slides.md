%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# StatefulSet


<br>

* déploiement des applications stateful (bases de données par ex)

<br>

* particularité :
		- ordonnées (dans le lancement)
		- garde en mémoire les volumes attachés

<br>

* création de service headless pour dns interne (chaque pods à un dns)

-----------------------------------------------------------------------

# Création des Persistent Volumes

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv0 # à modifier
spec:
  storageClassName: manual
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/pvdata0" # à modifier
---
```

Attention : sans stockage distribué créer pour la démo un répertoire/fichier sur chaque noeud

------------------------------------------------------------------------

apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: monstatefulset
spec:
  replicas: 4
  selector:
    matchLabels:
      app: monsts
  template:
    metadata:
      labels:
        app: monsts
    spec:
      containers:
      - name: nginx
        image: nginx
        volumeMounts:
        - name: www
          mountPath: /var/www/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      storageClassName: manual
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi

