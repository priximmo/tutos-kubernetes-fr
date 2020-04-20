%title: Kubernetes 
%author: xavki

# HELM : installation de wordpress


<br>
* Wordpress :
	* datas applicatives (wordpress)
	* datas base de données (mariadb)

<br>
* création d'un répertoire local pour stockage hostpath (pv)

* sur les nodes/workers :

```
ssh -o "StrictHostKeyChecking no" vagrant@node05 "sudo mkdir -p /wordpress/files && sudo mkdir -p /wordpress/db && sudo chmod -R 775 /wordpress"
```

----------------------------------------------------------------------------

# HELM : wordpress


<br>
* installation pv mariadb :

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mariadb-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /wordpress/db
```

---------------------------------------------------------------------------------

# HELM : wordpress


<br>
* installation pv wordpress :

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: wordpress-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /wordpress/files
```

-----------------------------------------------------------------------------

# HELM : wordpress


<br>
* installation pvc wordpress :

```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: wordpress-wordpress
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

-----------------------------------------------------------------------------

# HELM : wordpress


<br>
* installation pvc mariadb :

```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: data-wordpress-mariadb-0
spec:
  #storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```



```
helm install --set wordpressUsername=admin,wordpressPassword=adminpassword,mariadb.mariadbRootPassword=secretpassword,mariadb.master.persistence.existingClaim=data-wordpress-mariadb-0,persistence.existingClaim=wordpress-wordpress,allowEmptyPassword=false stable/wordpress --generate-name
