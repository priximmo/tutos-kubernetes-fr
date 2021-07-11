%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# NFS PROVISONNER > manager dynamiquement un volume nfs

<br>

Dépôt : https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner

POD1 > PVC1 > SC > VOLUME NFS / dir1
POD2 > PVC2 > SC > VOLUME NFS / dir2
POD3 > PVC3 > SC > VOLUME NFS / dir3

https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/
blob/master/charts/nfs-subdir-external-provisioner/README.md

-----------------------------------------------------------------------------------

# NFS PROVISONNER > manager dynamiquement un volume nfs

<br>

* déploiement via une HelmRelease

```
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: nfs-exporter
  namespace: nfs
spec:
  releaseName: nfs-exporter
  chart:
    name: nfs-subdir-external-provisioner
    version: 4.0.12
    repository: https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
  values:
    nfs:
      server: 192.168.12.20
      path: /srv/provisionner/
```

--------------------------------------------------------------------------------------

# NFS PROVISONNER > manager dynamiquement des volumes nfs

<br>

* utilisation - création d'un PVC

```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
  annotations:
    nfs.io/storage-path: "test-path" 
spec:
  storageClassName: nfs-client
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi
```

--------------------------------------------------------------------------------------

# NFS PROVISONNER > manager dynamiquement des volumes nfs


<br>

* utilisation - création d'un PVC

```
apiVersion: v1
kind: Pod
metadata:
  name: test-pvc
spec:
  volumes:
    - name: test-pvc
      persistentVolumeClaim:
        claimName: test-claim
  containers:
    - name: mycontainer
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: test-pvc
```

--------------------------------------------------------------------------------------

# NFS PROVISONNER > manager dynamiquement des volumes nfs

<br>

* test

```
kubectl run debug --rm -ti --image=curlimages/curl -- sh
```
