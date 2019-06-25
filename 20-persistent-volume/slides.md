%title: Kubernetes 
%author: xavki

# Pods : Persistent Volumes


<br>
* kubernetes propose du provisioning
		- persistentVolumes et persistentVolumesClaim


* ressources spécifiques


<br>
* imbrication :
		PV > PVC > Pods
		provisioning > quota pods > utilisation pods


----------------------------------------------------------------


# Persistent Volume


```
kind: PersistentVolume
apiVersion: v1
metadata:
  name: monpv
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/pvdata"
```


-----------------------------------------------------------------

# Persistent Volume Claim


```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: monpvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

-----------------------------------------------------------------


# Utilisation par les Pods


```
kind: Pod
apiVersion: v1
metadata:
  name: monpods
spec:
  volumes:
    - name: monstorage
      persistentVolumeClaim:
       claimName: monpvc
  containers:
    - name: monnginx
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: monstorage
```



