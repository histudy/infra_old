common
=========

ユーザーの追加や基本的なパッケージのインストールなど
サーバーの共通のセットアップ処理を行います

Role Variables
--------------

| 変数名                       | 内容                                                                                     |
| ---------------------------- | ---------------------------------------------------------------------------------------- |
| common_packages              | 共通でインストールするパッケージ名を設定します                                           |
| common_users                 | サーバーに登録するユーザーを設定します                                                   |
| common_requre_sudo_password | sudoでコマンドを実行する場合にパスワードの入力を必要とするか否かを設定します |
| common_fail2ban_cfg          | fail2banの設定を定義します                                                               |

### common_packages

共通でインストールするパッケージ名を指定します。

#### Example

```
common_packages:
  - build-essential
  - curl
  - wget
  - sudo
  - perl
  - task-japanese
  - bash-completion
  - vim
  - git
```

### common_users

ユーザーの変数には以下の属性が指定できます。

| 属性名 | 必須 | 型      | 内容                                        |
| ------ | ---- | ------- | ------------------------------------------- |
| name   | ○    | string  | ユーザー名(Githubのアカウント名)            |
| admin  |      | boolean | ユーザーが管理者の場合は `yes` を設定します |
| shell  |      | string  | ログインシェルを指定します                  |

#### Example

```
common_users:
  - name: wate
    admin: yes
  - name: sperkbird
    admin: yes
  - name: 223n
    admin: yes
  - name: nogajun
    admin: yes
  - name: fu7mu4
  - name: akihiro0105
```

### common_requre_sudo_password

sudoでコマンド実行する場合に
パスワードの入力を必要とするか否かを設定します。
※管理ユーザーの場合のみ

#### Example

```
common_admin_requre_password: no
```

### common_fail2ban_cfg

fail2banの設定をハッシュで指定します。

#### Example

```
common_fail2ban_cfg:
  sshd:
    enabled: yes
```

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: common }

License
-------

MIT
