%title: Kubernetes 
%author: xavki

# Pods : ressources

<br>
* 2 cas à retenir :
	- requests : minimum par conteneur
		- important pour la répartition sur les noeuds (scheduler)
	- limits : maximum par pod
		- important pour la santé des pods (kubelet)

* 2 types : 
	- CPU (100m = 0.1 CPU ou 0.5 )
	- Mémoire : 100M

* spec > resources

* ressource : ResourceRequirements 
	- communément : Deployment, StatefulSet et DameonSet

* limit process :
	- kubernetes > docker > linux kernel

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

* Mi : MebiBytes


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


