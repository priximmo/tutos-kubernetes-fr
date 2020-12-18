%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog : [Xavki Blog](https://xavki.blog)




-> Kubernetes / K8S : origines <-



Kubernetes : grec timonier ou pilote (cf logo)


<br>


* Origine 2015 (1.0) : Google reverse à CNCF (Cloud Native Computing Foundation)

* CNCF : Amazon, Google, Huawei, Oracle, Docker, Citrix, eBay, Reddit, MasterCard...

<br>


* Google en 2014 : 2 milliards de conteneurs lancés par semaine

<br>


* raccourci : orchestrateur de conteneur (comme Swarm pour docker mais bien plus poussé)

<br>


* conteneurs : docker mais pas que (CoreOS...)

 
-------------------------------------------------------------------------------------------------------


-> Kubernetes : pourquoi ? <-




<br>


* pour orchestrer : comme swarm (lancement orchestré de multiples conteneurs)


<br>


* pour créer de l'abstraction avec la notion de service (plus en IP)


<br>


* pour apporter de la haute disponibilité (maintenir les conteneurs up)


<br>


* pour scaler : lancer de multiples instances en fonction de paramètres (à la main ou en automatique)


<br>


* peu importe le provider : vsphere (vmware), google cloud, aws, azure, bare metal (physique)

------------------------------------------------------------------------------------------------------


-> Kubernetes : cluster ou minikube <-


* en mode cluster : un master et des noeuds esclaves


* en mode démo/test : avec minikube
		- nécessité d'avoir virtualbox
		- image déployée automatiquement sur un vbox




