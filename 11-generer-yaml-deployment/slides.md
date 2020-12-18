%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# Kubernetes : yaml, les fichiers descriptifs


<br>

## Pourquoi passer par les fichiers de conf ?


<br>

* la cli c'est bien en abuser ça craint...

* un fichier est préférable car les configurations sont souvent complexes 

* c'est aussi un moyen de sauvegarder les déploiements (versionner, gitter...)


<br>

## Génération des fichiers par la CLI


<br>

* génération d'un yaml à partir d'un déploiement existant

```
kubectl create deploy monnginx --image nginx
kubectl get deploy nginx -o yaml > mondeploy.yaml 
```

<br>

* génération du service en yaml

```
kubectl create service nodeport monnginx --tcp=8080:80
kubectl get service nginx -o yaml > monservice.yaml
```

---------------------------------------------------------------------------------------


# Kubernetes : lancement des fichiers deploy et services 


<br>

* création et lancement du déploiement (lancement) :

```
kubectl apply -f mondeploy.yml
```

* création et lancement du service :

```
kubectl apply -f monservice.yml
```

<br>

## Orchestrer un déploiement

* Astuce : concatener les 2 fichiers :

```
cat mondeploy.yaml monservices.yaml >appli.yaml
```

Rq : séparer par "---" les ressrouces (kind)
