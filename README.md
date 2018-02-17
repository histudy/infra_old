nginx
=========

[Nginx](https://nginx.org/)のインストールとセットアップを行います

Role Variables
--------------

| 変数名         | 内容                                          |
| -------------- | --------------------------------------------- |
| nginx_packages | インストールするNginxのパッケージを設定します |

###

インストールするNginxのパッケージを設定します。

#### Example

```yml
nginx_packages:
  - nginx
```

Dependencies
------------

* [apt-backports](https://github.com/histudy/ansible-role-apt-backports)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: nginx }
```

License
-------

MIT
