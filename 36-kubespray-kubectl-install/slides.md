%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# KUBESPRAY suite installation



<br>

* installation de kubectl sur une machine distante

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

* check avant récupération des certificats

```
kubectl cluster-info
```

-------------------------------------------------------------------


# KUBESPRAY : certificat d'admin


<br>

* sur un des master, récupération du certificat

```
cat /etc/kubernetes/admin.conf
```

<br>

* ajout du certificat sur la machine distante

```
mkdir -p ~/.kube
vim ~/.kube/config
kubectl cluster-info
kubectl get nodes
```

--------------------------------------------------------------------


# KUBESPRAY : autocomplétion



<br>

* disposer de l'autocomplétion :

prérequis :

```
apt-get install bash-completion
```

installation :

```
echo "source <(kubectl completion bash)" >> ~/.bashrc
```

---------------------------------------------------------------------


# KUBESPRAY : Alias bashrc


``` 
alias k='kubectl'

alias kcc='kubectl config current-context'

alias kg='kubectl get'

alias kga='kubectl get all --all-namespaces'

alias kgp='kubectl get pods'

alias kgs='kubectl get services'

alias ksgp='kubectl get pods -n kube-system'

alias kuc='kubectl config use-context'
```

