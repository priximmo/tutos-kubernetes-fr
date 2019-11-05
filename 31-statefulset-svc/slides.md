%title: Kubernetes 
%author: xavki

# StatefulSet - Service Headless


<br>
* création de service headless pour dns interne qui résoud tous les pods

* utiles pour les BDD distribuées qui incluent un round robin / LB interne


-----------------------------------------------------------------------

# StatefulSet

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: monstatefulset
spec:
  serviceName: svc-dns 
  replicas: 5
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
```

-----------------------------------------------------------------------

# Service Headless : none

```
apiVersion: v1
kind: Service
metadata:
  name: svc-dns
  labels:
    app: monginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: monsts  # important pour la sélection des pods entrant dans le dns
```


-------------------------------------------------------------------------

# Test

```
apt-get update && apt-get install -y dns-utils
nslookup svc-dns
```
