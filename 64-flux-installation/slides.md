%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# FLUX : Installation


<br>


* installation binaire > installation k8s


<br>


INSTALLATION DU BINAIRE

<br>


* sur ubuntu :

```
sudo snap install fluxctl
```

<br>


* via le binaire

```
wget https://github.com/fluxcd/flux/releases/download/1.21.0/fluxctl_linux_amd64
sudo mv fluxctl_linux_amd64 /usr/local/bin/fluxctl
chmod 755 /usr/local/bin/fluxctl
```


-------------------------------------------------------------------------------

# FLUX : Installation



INSTALLATION DANS LE CLUSTER

<br>


* création du namespace dédié

```
kubectl create ns fluxcd
```

<br>


* installation via apply

```
fluxctl install --git-email=moi@moi.com --git-url=git@gitlab.com:xavki/testflux.git --git-path=workloads --namespace=fluxcd | kubectl apply -f -
```

Rq : organisation (namespace,workloads)

<br>


* chargement de la clef ssh pour l'accès au dépot

```
fluxctl identity --k8s-fwd-ns fluxcd
```
