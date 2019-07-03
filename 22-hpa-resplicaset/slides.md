%title: Kubernetes 
%author: xavki

# ReplicaSet : HPA


<br>
* HPA : Horizontal Pods Autoscallers

<br>
* opposition avec VPA (Vertical)

* complémentaires avec CA (Cluster Autoscaller)

<br>
* multiplier le nombre de pods en fonction des ressources
		- min et max
		- seuil de déclenchement

<br>
* à éviter plutôt deployement


<br>
* ressource : 

```
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
```

<br>

pod > replicaset > HPA


-------------------------------------------------------------------------

# Squelette



<br>

```
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: frontend-scaler
spec:
  scaleTargetRef:
    kind: ReplicaSet
    name: frontend
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 10
```

* CLI

```
kubectl autoscale rs frontend --max=10
```
