%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


-> Kubernetes : scaling <-


<br>


* scaling : création de même instance du me service
		- supporter la charge principalement

* CLI : pour de la démo

```
kubectl create deployment monnginx --image nginx
```

<br>

* exemple nginx :

```
kubectl create service nodeport monnginx --tcp 8080:80
```

<br>

* éditer notre pod

```
kubectl exec -ti monnginx-xxx /bin/bash
echo "instance 1" > /usr/share/nginx/html/index.html
```

-----------------------------------------------------------------

-> Scale horizontal <-


<br>

* CLI

```
kubectl scale deployment monnginx --replicas=2
```

<br>

* Edition du second pod

```
kubectl exec -ti monnginx-xxx /bin/bash
echo "instance 1" > /usr/share/nginx/html/index.html
```

<br>

* autoscale

```
kubectl autoscale deployment monnginx --min=2 --max=10
```
