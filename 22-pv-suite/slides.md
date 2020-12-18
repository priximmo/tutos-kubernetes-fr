%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Persistent Volumes suite


<br>

* Server NFS > PV > PVC > Pod

<br>

* suivant provider, utilisation de reclaimPolicy :
	- delete : si suppression du PVC > sup du PV
	- recycle : recyclage (on n ele perd pas mais il est vidé)
	- retain : volume conservé mais versionné

* Suivant les règles Access Modes des PV :
	- connecter plusieurs pods sur le même volume
  - supprimer un pod et en relancer un nouveau avec les mêmes datas

Types :
  - ReadWriteOnce : monté sur un simple pod
  - ReadOnlyMany : montés sur plusieurs pods en lecture
  - ReadWriteMany : lecture écriture sur plusieurs pods


* Démo

---------------------------------------------------------------------------

# Création d'un PV

<br>

* création du PV

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mynfspv
spec:
  storageClassName: myclass
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteMany
  #persistentVolumeReclaimPolicy: Delete
  nfs:
    server: 192.168.56.1
    path: "/srv/exports"
```

---------------------------------------------------------------------------

# Création du PVC


<br>

* création du PVC

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mynfspvc
spec:
  storageClassName: myclass
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 500Mi
```


---------------------------------------------------------------------------

# Exemple avec des datas BDD


<br>

* attention : particularité BDD (deploy/statefulset)

<br>

* création du PV

```
apiVersion: v1
kind: Pod
metadata:
  name: debian-deploy
spec:
  containers:
  - image: mysql:5.6
    name: mysql
    env:
    - name: MYSQL_ROOT_PASSWORD
      value: "123456"
    ports:
    - containerPort: 3306
    volumeMounts:
    - mountPath: /var/lib/mysql
      name: monvolume
  volumes:
  - name: monvolume
    persistentVolumeClaim:
      claimName: mynfspvc
```

Exemple : delete pod et recréation sur le même volume

--------------------------------------------------------

# Exemple : connexion de plusieurs pods à 1 volume


Pod 1 : nginx

<br>

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-deploy
spec:
  containers:
  - image: nginx
    name: monnginx
    resources: {}
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: monvolume
  volumes:
  - name: monvolume
    persistentVolumeClaim:
      claimName: mynfspvc
```

----------------------------------------------------------


Pod 2 : debian

<br>

```
apiVersion: v1
kind: Pod
metadata:
  name: debian-deploy
spec:
  containers:
  - image: debian
    name: madebian
    resources: {}
    volumeMounts:
    - mountPath: /tmp/
      name: monvolume
  volumes:
  - name: monvolume
    persistentVolumeClaim:
      claimName: mynfspvc
```
