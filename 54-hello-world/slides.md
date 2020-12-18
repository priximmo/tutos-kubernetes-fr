%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# HELM : hello world

<br>

* liste des charts

```
helm list --kubeconfig /etc/rancher/k3s/k3s.yaml
```

<br>

```
hello-world /
  Chart.yaml 		# Description Chart
  values.yaml		# Variables (template)
  templates /		# templates de manifests
  charts /			# sous charts (optionnel)
  .helmignore		# ignorer des fichiers pour le dépôt
```

<br>

* création d'un chart

```
helm create hello-xavki
```

<br>

* lancement

```
helm install --kubeconfig /etc/rancher/k3s/k3s.yaml hello-xavki ./hello-xavki/
```

<br>

* suppression

```
helm uninstall --kubeconfig /etc/rancher/k3s/k3s.yaml hello-xavki ./hello-xavki/
```


* fichiers joints

