%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# StatefulSet - SGBD Cassandra


<br>

Plusieurs problématiques :
* le stockage persistant
* la communication entre les noeuds (assurer la distribution BDD)
* l'initialisation des noeuds


<br>

1- Classe de stockage - Storage Class

```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: cassandra-local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer  # attente d'au moins un pod
```


-------------------------------------------------------------------------

# StatefulSet Cassandra : PV

2- Volume persistant - PV

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: cassandra-local-storage-kubnode
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain # on supprime pas
  storageClassName: cassandra-local-storage
  hostPath:
    path: /srv/data/cassandra
    type: DirectoryOrCreate # création auto
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:	# PV placé sur le host kubnode
        - key: kubernetes.io/hostname
          operator: In
          values:
          - kubnode
```

Rq : idem pour kubnode2


-----------------------------------------------------------------------

# StatefulSet Cassandra : Service Headless


```
apiVersion: v1
kind: Service
metadata:
  labels:
    app: cassandra
  name: cassandra
spec:
  clusterIP: None  # headless
  ports:
  - port: 9042
  selector:
    app: cassandra
```

# fichier statefulset
