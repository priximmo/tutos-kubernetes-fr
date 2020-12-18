%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# FLUXCD : CLI - GESTION MULTI-ENVIRONNEMENT


<br>

Comment gérer différents environnements ?

<br>

* prendre en compte la politique déjà adoptée : namespace ou cluster ou autres

<br>

* via l'arborescence (1 directory = 1 env)

```
for i in prod preprod dev; do mkdir -p $i/{workloads,namespaces} $i;done
```

Avantage : 
	* simplicité de lecture pour les non inités à git
	* utilisation des branches à d'autres fins
	* plus intuitif peut être

Inconvénients :
	* gestion des droits
	* risques d'erreurs directes (MR impact tous les environnements)

------------------------------------------------------------------------------

# FLUX : CLI - GESTION MULTI-ENVIRONNEMENT


```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/testflux.git \
--git-path=dev \
--git-branch=master \
--namespace=fluxcd | kubectl apply -f -
```

```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/testflux.git \
--git-path=preprod \
--git-branch=master \
--namespace=fluxcd | kubectl apply -f -
```

```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/testflux.git \
--git-path=prod \
--git-branch=master \
--namespace=fluxcd | kubectl apply -f -
```

------------------------------------------------------------------------------

# FLUX : CLI - GESTION MULTI-ENVIRONNEMENT


<br>

* via les dépôts (1 dépôt = 1 env)

Avantage :
	* gestion des droits fine
	* utilisations des branches possibles pour s'organiser

Inconvénients:
	* non centralisé
	* de multiples dépôts à gérer (reste limité)

------------------------------------------------------------------------------

# FLUX : CLI - GESTION MULTI-ENVIRONNEMENT


```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/cluster-dev.git \
--git-path=workloads,namespaces \
--git-branch=master \
--namespace=fluxcd | kubectl apply -f -
```

```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/cluster-preprod.git \
--git-path=workloads,namespaces \
--git-branch=master \
--namespace=fluxcd | kubectl apply -f -
```

```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/cluster-prod.git \
--git-path=workloads,namespaces \
--git-branch=master \
--namespace=fluxcd | kubectl apply -f -
```

------------------------------------------------------------------------------

# FLUX : CLI - GESTION MULTI-ENVIRONNEMENT

<br>

* via les branches (1 branche = 1 env)

Avantages :
	* gestion des droits (branches protégées)
	* moins de risque d'erreurs si initiés à Git
	* MR à impacts limités à un environnement
	* orientation gitflow

Inconvénients :
	* initiés à Git

------------------------------------------------------------------------------

# FLUX : CLI - GESTION MULTI-ENVIRONNEMENT


```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/cluster-k8s.git \
--git-path=workloads,namespaces \
--git-branch=dev \
--namespace=fluxcd | kubectl apply -f -
```

```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/cluster-k8s.git \
--git-path=workloads,namespaces \
--git-branch=preprod \
--namespace=fluxcd | kubectl apply -f -
```

```
fluxctl install --git-email=moi@moi.com \
--git-url=git@gitlab.com:xavki/cluster-k8s.git \
--git-path=workloads,namespaces \
--git-branch=prod \
--namespace=fluxcd | kubectl apply -f -
```

------------------------------------------------------------------------------

# FLUX : CLI - GESTION MULTI-ENVIRONNEMENT


```
wget https://github.com/fluxcd/flux/releases/download/1.21.0/fluxctl_linux_amd64
sudo mv fluxctl_linux_amd64 /usr/local/bin/fluxctl
chmod 755 /usr/local/bin/fluxctl
kubectl create ns fluxcd
```

* via le namespace et plusieurs flux....?!?
