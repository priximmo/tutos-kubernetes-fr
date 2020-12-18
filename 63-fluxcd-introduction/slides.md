%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# FLUX : GitOps Tool


<br>

* outil de continuous deployement (CD)

* de la famille des gitops kubernetes
		* nokubectl

```
cluster kub + flux >< gitlab/github < dépôt git descriptif
```

<br>

* scrutation de dépôts descriptifs

<br>

* mise à jour automatique des ressources

<br>

* peut être couplé à Helm

<br>

* sous forme d'operator (extension des ressources d'un cluster)

<br>

* check à fréquence régulière (5min)

<br>

* concurrence > argocd / jenkins x

<br>

Dépôt : https://github.com/fluxcd/flux
Site: https://fluxcd.io/

---------------------------------------------------------------------------------

# FLUX : GitOps Tool



<br>

PLUS :

* command line : fluxctl

* simple d'utilisation et d'installation

* prend en compte les modifications de dépôts ou d'images

* garbage collector : prise en compte de la suppression totale

* provider terraform : 
		https://registry.terraform.io/modules/runoncloud/fluxcd/kubernetes/latest

<br>

MOINS :

* limité à un namespace et un repo (potentiellement plusieurs flux)

* pas de GUI


---------------------------------------------------------------------------------

# FLUX : GitOps Tool


Architecture :

	https://fluxcd.io/img/flux-cd-diagram.png
