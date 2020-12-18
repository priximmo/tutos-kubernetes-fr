%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# RANCHER : monitoring Prometheus/Grafana


<br>

* installation dans votre cluster via GUI

* prometheus grafana dans un namespace dédié

* ne permet pas l'accès distant (ClusterIP)

* nécessité de créer un ingress (accesible depuis extérieur)

* se rendre dans la GUI > cluster > tools > monitoring

<br>

* attention :
		* CPU : 4 par master
		* ram : 4G par worker
		* vagrant : passer par virtualbox (arrêt/modif/restart)

--------------------------------------------------------


# RANCHER : monitoring Prometheus/Grafana


<br>

* problème ns ingress-nginx (default) vs ns cattle-prometheus

<br>

* solution 1 : changer cluterip > nodePort
	
```
kubectl edit svc access-prometheus -n cattle-prometheus
```

Rq :faire pointer le loadbalancer externe vers ce port

<br>

* solution 2 :

<br>

* idée : créer un service dans le ns default
		* vers le dns interne du service de cattle-prometheus

* ingress > svc default > svc cattle-prometheus > deploy


---------------------------------------------------------------

# RANCHER : monitoring Prometheus/Grafana


<br>

* service / default

```
kind: Service
apiVersion: v1
metadata:
  name: graf
spec:
  type: ExternalName
  externalName: access-grafana.cattle-prometheus.svc.cluster.local
  ports:
  - port: 80
---
kind: Service
apiVersion: v1
metadata:
  name: prom
spec:
  type: ExternalName
  externalName: access-prometheus.cattle-prometheus.svc.cluster.local
  ports:
  - port: 80

```

------------------------------------------------------------------------------


# RANCHER : monitoring Prometheus/Grafana


<br>

* création d'un ingress vers le service de default

```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: grafana
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: graf.kub
    http:
      paths:
      - path: /
        backend:
          serviceName: graf
          servicePort: 80
```

------------------------------------------------------------------------------


# RANCHER : monitoring Prometheus/Grafana


<br>

```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: prometheus
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: prom.kub
    http:
      paths:
      - path: /
        backend:
          serviceName: prom
          servicePort: 80
```
