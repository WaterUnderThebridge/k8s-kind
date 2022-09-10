# k8s-kind

# 环境说明
  使用kind安装简单的k8s集群，安装集群只需要一台centos7.6主机, install.sh 一键安装，安装过程包括docker程序的安装，镜像文件的加载，kind和kubectl的安装，以及使用kind 创建集群。注意k8s集群是部署在docker容器内。

# 安装方法:

## 使用安装包安装
1. 构建安装包(使用makeself工具构建)
~~~shell
sudo  makeself/makeself.sh --tar-extra "--exclude=.git"  k8s-kind/  k8s-kind.run "k8s installing ..."  ./install.sh 
~~~
2. 使用安装包安装
~~~shell
./ k8s-kind.run
~~~

## 直接脚本安装
~~~shell
cd k8s-kind && ./install.sh
~~~
