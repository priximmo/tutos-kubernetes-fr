%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)




-> Kubernetes : minikube <-




<br>

* Kubernetes "version portable" :
		- moins de ressources
		- un cluster sur un noeud


* apprendre/tester/démo



-------------------------------------------------------------------------


-> Minikube : installation <-


* téléchargement du fichier d'install :

```
apt-get install virtualbox

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
```

Rq : l'install comprend un téléchargement d'une iso pour VBox


* déplacement du binaire dans le PATH :

```
sudo cp minikube /usr/local/bin && rm minikube
```

Lien : https://kubernetes.io/docs/tasks/tools/install-minikube/
