%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# K3S : ingress controller TRAEFIK


<br>

* check traefik

```
kubectl get all -n kube-system
```

Rq : master

<br>

* FLUX :


1. master 80/443 >> pod/daemonset traefik

2. traefik >> ingress

3. ingress >> service

4. service >> pods


-----------------------------------------------------------------------


# K3S : ingress controller TRAEFIK



<br>

* exemple de Hello1

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-un
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-un
  template:
    metadata:
      labels:
        app: hello-un
    spec:
      containers:
      - name: hello-kubernetes
        image: paulbouwer/hello-kubernetes:1.7
        ports:
        - containerPort: 8080
        env:
        - name: MESSAGE
          value: Hello je suis le UN !!!

```

-----------------------------------------------------------------------


# K3S : ingress controller TRAEFIK



<br>

* exemple de Hello2

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-deux
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hello-deux
  template:
    metadata:
      labels:
        app: hello-deux
    spec:
      containers:
      - name: hello-kubernetes
        image: paulbouwer/hello-kubernetes:1.7
        ports:
        - containerPort: 8080
        env:
        - name: MESSAGE
          value: Hello je suis le DEUX !!!

```

-----------------------------------------------------------------------



# K3S : ingress controller TRAEFIK


<br>

* création des services

```
apiVersion: v1
kind: Service
metadata:
  name: hello-un
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: hello-un
---
apiVersion: v1
kind: Service
metadata:
  name: hello-deux
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: hello-deux
```


-----------------------------------------------------------------------


# K3S : ingress controller TRAEFIK


```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: hello-ingress
  annotations:
    kubernetes.io/ingress.class: "traefik"
    traefik.frontend.rule.type: PathPrefixStrip
spec:
  rules:
  - http:
      paths:
      - path: /hw1 # by path
        backend:
          serviceName: hello-un
          servicePort: 80
  - host: hw2.kub # by host header
    http:
      paths:
      - path: /
        backend:
          serviceName: hello-deux
          servicePort: 80
```

```
curl -H "Host:hw2.kub" 192.168.7.130
curl 192.168.7.130/hw1
```


