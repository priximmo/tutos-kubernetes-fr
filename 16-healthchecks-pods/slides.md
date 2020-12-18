%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

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

-------------------------------------------------------------------------

# Liveness et Readiness


<br>

* certaines applications ont besoin d'être restartées

* prévenir des images mal construites non fonctionnelles

* éviter les coupures lors de déploiements (zero downtime)

<br>

* liveness = restart automatique

* readiness = remplacement de pods défectueux

* les deux sont complémentaires

<br>

* exemple de scénario :

1- readiness = fail
2- > sortie du pods
3- liveness = fail
4- > restart du pods
5- liveness = ok
6- readiness = ok
7- > le pod intègre le pool

-------------------------------------------------------------------------

# Liveness et Readiness


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


#  par la commande


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


# par le httpGet


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


# par TCPSocket

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

----------------------------------------------------------------------


# Readiness et liveness : exemple httpGet


<br>

```
readinessProbe:
  httpGet:
    path: /monitoring/alive
    port: 3401
  initialDelaySeconds: 5
  timeoutSeconds: 1
  periodSeconds: 15
livenessProbe:
  httpGet:
    path: /monitoring/alive
    port: 3401
    initialDelaySeconds: 15
    timeoutSeconds: 1
    periodSeconds: 15
```

----------------------------------------------------------------------

# Readiness et liveness : exemple command


```
readinessProbe:
  exec:
    command:
    - find
    - alive.txt
    - -mmin
    - '-1'
  initialDelaySeconds: 5
  periodSeconds: 15
livenessProbe:
  exec:
    command:
    - find
    - alive.txt
    - -mmin
    - '-1'
  initialDelaySeconds: 15
  periodSeconds: 15
```
