%title: Kubernetes 
%author: xavki
%blog: [Xavki Blog](https://xavki.blog)



# StatefulSet


```
apiVersion: v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
   volumeClaimTemplates:
   - metadata:
     name: www
   spec:
     storageClassName: manual
     resources:
       requests:
         storage: 1Gi
