%title: Kubernetes 
%author: xavki

# Pods : checks


## Rappels :

<br>
```
kind: Pod
metadata:
  name: monpod
  labels:
    env: prod
spec:
  selector:
    env: prod
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  - name: mondebian
    image: debian
    command: ["sleep", "600"]
```
<br>
Connexion à un des conteneurs 

```
kubectl exec -ti monpod -c mondebian /bin/bash
```

--------------------------------------------------------

# Liveness et Readiness


<br>
* certaines application son besoin d'être restartées

<br>
* liveness = restart automatique

<br>
* multiples modes :
	- command > exec
	- http > httpGet
	- tcp > tcpSocket

<br>
* variables:
	- initialDelaySeconds : à partir de quand commence le check ?
	- periodSeconds : à quelle fréquence ?
	- timeoutSeconds : à partir de combien on timeout ?
	- successThreshold : au bout de combien de positifs on réactive ?
	- failureThreshold : au bout de combien de négatifs on sort ?

<br>
* httpGet :
	- Host : quel host (ip/adresse) ?
	- scheme : protocole (http ou https)
	- path : route vérifiée
	- httpHeaders : header spécifique
	- port : port à vérifier

-------------------------------------------------------------------------


# Liveness par la commande


<br>
* exemple doc k8s :

```
spec:
  containers:
  - name: liveness
    image: k8s.gcr.io/busybox
    args:
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```

-----------------------------------------------------------------------


# Liveness par le httpGet


<br>
* check sur une autre adresse :

```
spec:
  containers:
  - name: liveness
    image: nginx
    livenessProbe:
      httpGet:
        path: /
        host: www.google.fr
        port: 443
        scheme: HTTPS
      initialDelaySeconds: 3
      periodSeconds: 3
```


-----------------------------------------------------------------------


# Liveness par TCPSocket

<br>
* idem mais en tcp

```
spec:
  containers:
  - name: liveness
    image: nginx
    livenessProbe:
      tcpSocket:
        port: 80
        host: google.fr
      initialDelaySeconds: 15
      periodSeconds: 20
```
