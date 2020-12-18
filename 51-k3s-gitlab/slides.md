%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# K3S & GITLAB CI


<br>

* créer un projet gitlab

<br>

* installation du cluster

<br>

* récupération du certificat

```
kubectl config view --raw -o=jsonpath='{.clusters[0].cluster.certificate-authority-data}' | base64 --decode
```

-----------------------------------------------------------------------------


# K3S & GITLAB CI


<br>

* rbac gitlab

```
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: gitlab-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: gitlab-admin
  namespace: kube-system
```

<br>

* récupération du token

```
SECRET=$(kubectl -n kube-system get secret | grep gitlab-admin | awk '{print $1}')
TOKEN=$(kubectl -n kube-system get secret $SECRET -o jsonpath='{.data.token}' | base64 --decode)
echo $TOKEN
```

-----------------------------------------------------------------------------


# K3S & GITLAB CI


<br>

* installation du runner

<br>

* test

```
stages:
- deploy

variables:
  MESSAGE: "Hello World."

app-deploy:
  stage: deploy
  tags:
      - kubernetes
  environment:
    name: deploy
  script:
    - echo $MESSAGE
  only:
    - master
```
