# provision

利用方法
========================

Ansibleのインストール
----------------------------

#### Mac OSX

1. 以下のコマンドを実行してください。

```shell
brew install ansible
```

#### Ubuntu

1. 以下のコマンドを実行してください。

```shell
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

#### Debian

1. 以下のコマンドを実行してください。

```shell
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >/etc/apt/sources.list.d/ansible.list
sudo apt-get install -y dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt-get update
sudo apt-get install ansible
```

#### Windows

1. 「Winsowsの機能の有効化または無効化」より「Windows Subsystem for Linux」を有効化にします。
1. 「Windowsストア」から「Ubuntu」をインストールします。
1. Ubuntuのインストール手順に従いインストールを行ってください。

##### 参考URL

[Installation — Ansible Documentation](http://docs.ansible.com/ansible/latest/intro_installation.html)

ロールのインストール
----------------------------

```shell
ansible-galaxy install -r requirements.yml
```
