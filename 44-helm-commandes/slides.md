%title: Kubernetes 
%author: xavki

# HELM


<br>
* Pourquoi faire ?
	* gestionnaire de paquets dédié à K8S
	* simplifier la génération des manifests yaml
	* versionning : updates/rollback
	* charts : stack

<br>
* installation :

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 755 get_helm.sh 
./get_helm.sh
```

-------------------------------------------------------------------------

# HELM : commandes

<br>
* lister les repository :

```
helm repo list
```

<br>
* rechercher un charts:

```
helm search hub wordpress
```

<br>
* helm hub :

```
https://hub.helm.sh/
https://hub.helm.sh/charts/bitnami/wordpress
```
