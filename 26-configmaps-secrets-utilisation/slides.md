%title: Kubernetes 
%author: xavki

# ConfigMaps et Secrets : utilisation


<br>
* création par la ligne de commande - CLI

<br>
* possibilité de créer par manifeste


<br>
```
kind: ConfigMap 
apiVersion: v1 
metadata:
  name: personne
data:
  nom: Xavier 
  passion: blogging
  clef: |
 
    age.key=40 
    taille.key=180
```


-----------------------------------------------------------------

# Utilisations : configMapKeyRef

<br>
* 2 types :
		- volumes
		- configMapKeyRef

<br>
* variables env

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env:
        - name: NOM
          valueFrom:
            configMapKeyRef:
              name: personne
              key: nom
        - name: PASSION
          valueFrom:
            configMapKeyRef:
              name: personne
              key: passion
```


-------------------------------------------------------------------

# Utilisations : configMapKeyRef


```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
    - name: test-container
      image: busybox
      command: [ "/bin/sh", "-c", "env" ]
      envFrom:
        - configMapRef:
            name: personne
```
