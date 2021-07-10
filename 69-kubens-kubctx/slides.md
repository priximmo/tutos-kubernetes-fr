%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# TOOLS : KUBENS et KUBECTX


<br>

* Contexte > cluster ( user/creds) + cluster

```
kubectl config view
```

* changer contexte

```
kubectl config get-context
kubectl config use-context minikube
```

<br>

```
sudo curl -sL https://github.com/ahmetb/kubectx/releases/download/v0.9.1/kubens -o /usr/local/bin/kubens && sudo chmod 755 /usr/local/bin/kubens
sudo curl -sL https://github.com/ahmetb/kubectx/releases/download/v0.9.1/kubectx -o /usr/local/bin/kubectx && sudo chmod 755 /usr/local/bin/kubectx
```
