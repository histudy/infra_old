python
=========

Pythonの基本パッケージをインストールします

Role Variables
--------------

| 変数名          | 内容                               |
| --------------- | ---------------------------------- |
| python_packages | Pythonの基本パッケージを設定します |

### python_packages

Pythonの基本パッケージを設定します

#### Example

```yml
python_packages:
  - python-setuptools
  - python-pip
  - python-dev
```

Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: python }
```

License
-------

MIT
