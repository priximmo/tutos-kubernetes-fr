%title: Kubernetes 
%author: xavki

# Pods

## Configuration : politique de restart


* idem docker

```
apiVersion: v1
kind: Pod
metadata:
  name: monpod
  namespace: xavki
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  restartPolicy: Always
```



