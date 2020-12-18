%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# KUBESPRAY & INGRESS CONTROLLER NGINX


<br>

```

                                          6443  +------------+
                                                |            |
       192.168.7.130      +------------+   +---->  Master1   |
                          |            |   |    |            |
                    +-----+  HAPROXY1  |   |    +------------+
                          |            |   |
                          +------------+   |
                          |            +---+    +------------+
                          |                |    |            |
                  80/443  |                +---->  Master2   |
                          |                     |            |
           +------------+ |    +------------+   +------------+
           |            | |    |            |
           |  Knode01   <------>  Knode0X   |
           |            |      |            |
           +------------+      +------------+
```


------------------------------------------------------------------------

# KUBESPRAY & INGRESS CONTROLLER NGINX



<br>

* FLUX :

0. Haproxy 80/443 >> KnodeXX

1. Knode >> pod/daemonset nginx

2. nginx >> ingress

3. ingress >> service

4. service >> pods


-----------------------------------------------------------------------


# KUBESPRAY & INGRESS CONTROLLER NGINX



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


# KUBESPRAY & INGRESS CONTROLLER NGINX


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


# KUBESPRAY & INGRESS CONTROLLER NGINX


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


# KUBESPRAY & INGRESS CONTROLLER NGINX


```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: hello-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:  # by path
      paths:
        - path: /hw1
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


