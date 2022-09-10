#!/bin/bash


sys_ver=$(cat /etc/redhat-release)
[[ ! "$sys_ver" =~ "CentOS Linux release 7.6.1810" ]] &&  {
    echo -e "\033[41;37m  CentOS INSTALL ERROR 请重新安装操作系统Centos7.6!!! \033[0m"
    exit 1
}

. ./functions.sh
echo "install start ..."
 
CURRENT_DIR=`pwd`
U=$USER
Echo_Green "1. install docker"
yum remove docker \
                  docker-ce  \
                  docker-ce-cli \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  container-selinux  -y  && \
tar -xf packages/docker-rpm.tar.gz -C /tmp && \
yum install /tmp/docker-rpm/*   -y  && \
systemctl enable docker && systemctl start docker


[ $? -ne 0 ] && exit -1
Echo_Green "2. load docker image kind-node"
docker load -i packages/kind_node-v1.25.0.tar.gz 


[ $? -ne 0 ] && exit -1
Echo_Green "3. install go and config environemnt variables"
rm -rf /usr/local/go && tar -C /usr/local -xzf packages/go1.19.1.linux-amd64.tar.gz && \
(grep 'GOPATH' /etc/profile || echo 'export GOPATH=/root/go' >> /etc/profile)  && \
(grep 'GOROOT' /etc/profile || echo 'export GOROOT=/usr/local/go' >> /etc/profile)  && \
grep 'PATH=$PATH:/usr/local/bin'  /etc/profile || {
echo '
export PATH=$PATH:${GOROOT}/bin:bin:${GOPATH//://bin/:}/bin
export PATH=$PATH:/usr/local/bin' >> /etc/profile 
}   

[ $? -ne 0 ] && exit -1
Echo_Green "4. install clients for kind,kubectl,nerdctl and config environment variables"
tar -xf packages/client.tar.gz  -C /  && \
(grep 'kubectl completion bash)' /etc/profile || echo 'source <(kubectl completion bash)' >> /etc/profile) && \
(grep 'k='  /etc/profile || echo 'alias k="kubectl"' >> /etc/profile) && \
(grep 'kk='  /etc/profile || echo 'alias kk="kubectl -n kube-system"' >> /etc/profile) && \
(grep 'export do='  /etc/profile || echo 'export do="--dry-run=client -o yaml"' >> /etc/profile) && \
(grep 'complete -F'  /etc/profile || echo 'complete -F __start_kubectl k' >> /etc/profile) && \
source /etc/profile && \

[ $? -ne 0 ] && exit -1
Echo_Green "5. install k8s using kind"
(kind get clusters|grep devops || kind create cluster --image kindest/node:v1.25.0 --name devops) && \
kubectl get cs
