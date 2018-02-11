apt-backports
=========

Debian Backportsをインストールします

Role Variables
--------------

| 変数名                       | 内容                                                               |
| ---------------------------- | ------------------------------------------------------------------ |
| apt_backports_default_target | デフォルトのターゲットをDebian Backportsに設定するか否か指定します |

### apt_backports_default_target

デフォルトのターゲットをDebian Backportsに設定するかどうかを指定します

#### Example

```yml
apt_backports_default_target: yes
```

Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: apt-backports }
```

License
-------

MIT
