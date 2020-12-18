%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Pods : Persistent Volumes - découverte


<br>

* kubernetes propose du provisioning
		- persistentVolumes et persistentVolumesClaim
		- sépration entre provisionning et consommation

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

Rq :
	- ReadWriteOnce : monté sur un simple pod
	-	ReadOnlyMany : montés sur plusieurs pods en lecture
	- ReadWriteMany : lecture écriture sur plusieurs pods

```
kubectl get pv
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

```
kubectl get pvc
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

