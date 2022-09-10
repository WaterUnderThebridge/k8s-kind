# k8s-kind

# 环境说明
  * 使用kind安装简单的k8s集群，安装集群只需要一台centos7.6主机, install.sh 一键安装，安装过程包括docker程序的安装，镜像文件的加载，kind和kubectl的安装，以及使用kind 创建集群。
  * 注意k8s集群是部署在docker容器内;docker 运行的容器devops-control-plane 是k8s的唯一节点

# 安装方法:

## 使用安装包制品安装
1. 构建成安装包制品(使用makeself工具构建)
~~~shell
sudo k8s-kind/makeself/makeself.sh --tar-extra "--exclude=.git"  k8s-kind/  k8s-kind.run "k8s installing ..."  ./install.sh
~~~
2. 运行安装包
~~~shell
sudo su
./ k8s-kind.run
~~~

## 直接脚本安装
~~~shell
cd k8s-kind && ./install.sh
~~~

# k8s测试
* 加载环境变量
source /etc/profile
* 创建容器测试(拉取镜像需要虚拟机能访问外网)
k run busybox --image=busybox --command sleep infinity
k get pod
