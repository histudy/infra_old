# 利用方法

## Ansibleのインストール

### Mac OSX

```shell
brew install ansible
```

### Ubuntu

```shell
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

### Debian

```shell
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >/etc/apt/sources.list.d/ansible.list
sudo apt-get install -y dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt-get update
sudo apt-get install ansible
```

### Windows

1. 「Winsowsの機能の有効化または無効化」より「Windows Subsystem for Linux」を有効化します。
2. 「Windowsストア」より「Ubuntu」をインストールします。
3. このREADME内の「Ubuntu」のインストール手順に従いインストールします。

#### 参考URL

* [Installation — Ansible Documentation](http://docs.ansible.com/ansible/latest/intro_installation.html)
* [Windows 10にUbuntuをインストールしよう - マイナビニュース](https://news.mynavi.jp/article/liunx_win-2/)

## ロールのインストール

```shell
ansible-galaxy install -r requirements.yml
```

## ロールの更新

```shell
ansible-galaxy install -f -r requirements.yml
```
