%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# KUBERNETES & RANCHER : manager de cluster


<br>

* manager un cluster = ressources + moyens

* plus facile dans le cloud

* plus dur on premise

* et plus on a de cluster...

<br>

* rancher : 
		*	provisionner des clusters : cloud à on premise
		* importer des clusters pour les managers
		* monitoring
		* alerting
		* outils : istio
		* sécurité : users, namespace...
		* cenraliser un kubectl via la console
		* consultation facile des yamls
		* backup de clusters (sous réserves)
		* mise à jour de cluster
		* rollbacks
		* clone de clusters (sous réserves)
		* rotate des certificats
		* scans de sécurité

------------------------------------------------------------------


# KUBERNETES & RANCHER : manager de cluster


<br>

* gestion par projet :
    * Assign users access to a group of namespaces
    * Assign users specific roles in a project. A role can be owner, member, read-only, or custom
    * Set resource quotas
    * Manage namespaces
    * Configure tools
    * Set up pipelines for continuous integration and deployment
    * Configure pod security policies

<br>

* pipeline :
    * Build your application from code to image.
    * Validate your builds.
    * Deploy your build images to your cluster.
    * Run unit tests.
    * Run regression tests.


