%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Pods : les Volumes


<br>

* toujours un point important : kubernetes, docker ou cloud


<br>

* conception de l'applicatif (différencier les données persistentes des autres)

* différents types : 
		- datas applicatives : fichiers images, fichiers plats...
		- logs : préférence pour export elk (mais parfois)
		- fichiers de conf (plutôt config maps)
		- fichiers partagées et/ou sauvegardés

<br>

* docker = 1 type en général

<br>

* kubernetes 4 types :
			- emptyDir : pas de persistence mais partage entre pods/conteneurs
			- hostPath : répertoire partagé avec le host qui héberge le pod (attention déplacement)
			- persistent volume claim
			- externe : par exemple NFS mais de nombreux autres (volumes claim, glusterfs, vsphere...)

Plus: https://kubernetes.io/docs/concepts/storage/volumes/ 


-------------------------------------------------------------------------------------------

# Volume : hostPath

<br>

* volume du host monté dans le pod (dans le conteneur)

<br>

* aujourd'hui votre pod est sur ce noeud mais demain sur un autre

* attention : uniquement sur le pod
		- en cas de mouvement perte de la data
		- prévoir un stockage sur toutes les machines (GlusterFS distribué, NFS...)

<br>

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: monvolume
  volumes:
  - name: monvolume
    hostPath:
      path: /srv/data
      type: Directory
```

-----------------------------------------------------------------------------------------

# Volume : emptyDir


<br>

* permet de partager un volume éphémère entre conteneurs d'un même pod

* répartir le travail entre les pods

<br>

```
spec:
  containers:
  - name: monnginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: monvolume
  - name: mondebian
    image: debian
    command: ["sleep", "600"]
    volumeMounts:
    - mountPath: /worktmp/
      name: monvolume
  - name: monalpine
    image: alpine
    command: ['sh', '-c', 'echo "Bonjour xavki" >/myjob/index.html' ]
    volumeMounts:
    - mountPath: /myjob/
      name: monvolume
  volumes:
  - name: monvolume
    emptyDir: {}
```

----------------------------------------------------------------------------------------

# Volume : emptyDir en ram


<br>


```
  volumes:
  - name: monvolume
    emptyDir:
      medium: Memory
```


