%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# Kubernetes : autocomplete, alias, accès distant


## Autocomplétion


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


## Alias bashrc


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

---------------------------------------------------------------------

## Kubectl à distance 


* accéder au cluster à distance


```
# install kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" 
sudo apt-get install kubectl

# create directory
mkdir ~/.kube

# copy token
ssh user@master "sudo cat /etc/kubernetes/admin.conf" >.kube/config
```

