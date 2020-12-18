%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# FLUX : via https


<br>

* création d'un secret sous kub (user/token)

```
export GIT_AUTHKEY="xxxxxxxxxxxxxxxxxx"
export GIT_AUTHUSER="xavki"
```

```
kubectl create secret generic flux-git-auth --namespace fluxcd --from-literal=GIT_AUTHUSER=$GIT_AUTHUSER --from-literal=GIT_AUTHKEY=$GIT_AUTHKEY
```

<br>

* modification de la connexion à gitlab/github

```
kubectl edit deployment flux -n fluxcd
```

```
        - --git-url=https://$(GIT_AUTHUSER):$(GIT_AUTHKEY)@gitlab.com/xavki/testflux.git
```

------------------------------------------------------------------------

# FLUX : via https

<br>

* injection des secrets sous forme de variables d'environnement


```
        env:
        - name: GIT_AUTHUSER
          valueFrom:
            secretKeyRef:
              key: GIT_AUTHUSER
              name: flux-git-auth
        - name: GIT_AUTHKEY
          valueFrom:
            secretKeyRef:
              key: GIT_AUTHKEY
              name: flux-git-auth
```

Rq : remove ssh éventuellement

<br>

* rollback des modification pour revenir à ssh

```
kubectl rollout history -n fluxcd deployment.v1.apps/flux
kubectl rollout history -n fluxcd deployment.v1.apps/flux --revision=5
```

* rollback 

```
kubectl rollout undo -n fluxcd deployment.v1.apps/flux --to-revision=5
```
