%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# Pods : ressources

<br>

* 2 cas à retenir :
	- requests : minimum par conteneur
		- important pour la répartition sur les noeuds (scheduler)
	- limits : maximum par pod
		- important pour la santé des pods (kubelet)

* ressources : metrics-server (slides suivants)

```
kubectl get apiservices
```

* 2 types : 
	- CPU (100m = 0.1 CPU ou 0.5 )
	- Mémoire : 100M

* spec > resources

* ressource : ResourceRequirements 
	- communément : Deployment, StatefulSet et DameonSet

* limit process :
	- kubernetes > docker > linux kernel

--------------------------------------------------------------------------------

# La collecte des métriques


<br>

* installation de metrics-server :
    - collecte de métriques pourles fournir par API (kubelet)
    - CPU ou mémoire notamment

<br>

0- agregation layer

```
https://kubernetes.io/docs/tasks/access-kubernetes-api/configure-aggregation-layer/
```

Rq : sauf si installation kubespray

<br>

1- clone de metrics-server

```
git clone https://github.com/kubernetes-incubator/metrics-server.git
```

-------------------------------------------------------------------------


# La collecte des métriques


<br>

2- sans tls

```
      - name: metrics-server
        image: k8s.gcr.io/metrics-server-amd64:v0.3.3
        command:
        - /metrics-server
        - --kubelet-insecure-tls
        - --kubelet-preferred-address-types=InternalIP
```

<br>

3- vérification

```
kubectl top nodes
```



--------------------------------------------------------------------------

# Exemple : la mémoire


<br>

```
resources:
  requests:
    memory: 50Mi
  limits:
    memory: 100Mi
```

* Mi : MebiBytes (ex : 50 / 1000)


Minimum pour un conteneur = 50 Mi

Maximum = 100 Mi


-------------------------------------------------------------------------


# Exemple : le CPU


<br>

```
resources:
  requests:
    memory: 50Mi
    cpu: 0.1
  limits:
    memory: 100Mi
    cpu 0.5
```

Remarque:
* 50m de CPU => 0.05 CPU
* 500m de CPU => 0.5 CPU

-------------------------------------------------------------------------


# La ressource : LimitRange


<br>

* défintion du comportement par défaut

<br>


```
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limit
spec:
  limits:
  - default: 				#limit default
      memory: 100Mi
      cpu: 100m
    defaultRequest: #request default
      memory: 50Mi
      cpu: 50m
  - max:						#limite acceptable
    memory: 512Mi
    cpu: 500m
  - min:
    memory: 50Mi		#limite acceptable
    cpu: 50m
    type: Container
```


