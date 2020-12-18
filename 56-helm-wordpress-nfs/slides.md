%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# HELM : installation de wordpress & NFS


<br>

* Wordpress :
	* datas applicatives (wordpress)
	* datas base de données (mariadb)

<br>

* création d'un répertoire local pour stockage hostpath (pv)

* sur les nodes/workers :

```
sudo mkdir -p /srv/wordpress/{db,files}
sudo chmod 777 -R /srv/wordpress/
sudo apt-get install nfs-kernel-server
ou sudo yum -y install nfs-utils rpcbind
sudo vim /etc/exports
/srv/wordpress/db 192.168.7.0/24(rw,sync,no_root_squash)
/srv/wordpress/files 192.168.7.0/24(rw,sync,no_root_squash)
sudo systemctl restart nfs rpcbind
sudo exportfs -a
# test sudo mount -t nfs 192.168.7.120:/srv/wordpress/db /tmp
```

* sans nfs

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
  storageClassName: mariadb
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: 192.168.7.120
    path: "/srv/wordpress/db"
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
  storageClassName: wordpress
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
    - ReadOnlyMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: 192.168.7.120
    path: "/srv/wordpress/files"
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
  storageClassName: wordpress
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
  storageClassName: mariadb
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```



```
helm install --set service.type=NodePort,ingress.enabled=true,ingress.hostname=wordpress.kub,wordpressUsername=admin,wordpressPassword=adminpassword,mariadb.mariadbRootPassword=secretpassword,mariadb.master.persistence.existingClaim=data-wordpress-mariadb-0,persistence.existingClaim=wordpress-wordpress,allowEmptyPassword=false bitnami/wordpress --generate-name
```
