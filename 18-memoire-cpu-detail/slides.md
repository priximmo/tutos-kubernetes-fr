%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Pods : mémoire et CPU... les dessous

<br>

* 2 cas à retenir :
	- requests : minimum par conteneur
		- important pour la répartition sur les noeuds (scheduler)
	- limits : maximum par pod
		- important pour la santé des pods (kubelet)

* 2 types : 
	- CPU (100m = 0.1 CPU)
	- Mémoire : 100M

<br>

* limit process :
	- kubernetes > docker > linux kernel

* démarches identiques pour cpu et mémoire

--------------------------------------------------------------------------


# Affectation de la mémoire


<br>

* sans limite

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: madebian
    image: debian
    command: ["/bin/bash","-c","while true; do sleep 2; done"]
```

<br>

* Docker : conteneur et filtre sur la limite de mémoire

```
docker inspect <nom_conteneur> -f "{{.HostConfig.Memory}}"
```

<br>

* Système : recherche du cgroup

```
ps aux | grep "/bin/bash"
sudo cat /proc/<num_pid>/cgroup
#puis
/sys/fs/cgroup/memory/kubepods/burstable/<pod_id>/memory.limit_in_bytes
```

---------------------------------------------------------------------------

# Avec une limite


<br>


```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: madebian
    image: madebian
    command: ["/bin/bash","-c","while true; do sleep 2; done"]
    resources:
      requests:
        memory: 50Mi
      limits:
        memory: 100Mi
```

* check du cgroup (cf slide précédente)



