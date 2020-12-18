%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Persistent Volumes : NFS


<br>

* installation du serveur nfs :

```
sudo apt-get install nfs-kernel-server
```

```
sudo vim /etc/exports
/srv/exports 192.168.56.0/24(rw,sync,no_root_squash)
sudo exportfs -a
```

<br>

* test sur le master kubernetes :

```
sudo mount -t nfs 192.168.56.1:/srv/exports /tmp
```


-----------------------------------------------------------

# Création du Persistent Volume


<br>

* manifeste PV :

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mynfspv
spec:
  storageClassName: manual
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  nfs:
    server: 192.168.56.1
    path: "/srv/exports"
```

-----------------------------------------------------------

# Création du Persistent Volume Claim


<br>

* manifest PVC :

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mynfspvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 500Mi
```

---------------------------------------------------------

# Création du Pod


<br>

* manifeste Pod :

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-deploy
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: www
  volumes:
  - name: www
    persistentVolumeClaim:
      claimName: pvc-nfs-pv1
```

Rq : édite de fichier + curl pour tester
