%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)




-> Kubernetes : notions <-


<br>

* Kubernetes apporte beaucoup de notions et de concepts


<br>

* noeuds (serveurs) : physiques ou virtuels
		- master ou simple noeud d'exécution

<br>

* pods : pierre centrale de K8S
		- ensemble cohérent de conteneurs
		- un ou plusieurs conteneurs
		- une instance de K8S

<br>

* service : abstraction des pods
		- permet d'éviter la communication par ip (changeante car on est en conteneurs)
		- service > ip/port > pods
		- service = ip et port fixe


----------------------------------------------------------------------


-> Suites des notions <-



<br>

* volumes: persistents ou non
		- lieux d'échanges entre pods
		- intérieur de pods = non persistent
		- extérieur = persistent

<br>

* deployments : objets de gestion des déploiments
		- création/suppression
		- scaling : gestion de paramètres pour la montée en charge (ou réduction)

<br>

* namespaces : cluster virtuel (ensemble de services)
		- sous ensemble pour cloisonner dans K8S

