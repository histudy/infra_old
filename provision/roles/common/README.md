common
=========

ユーザーの追加や基本的なパッケージのインストールなど
サーバーの共通のセットアップ処理を行います

Role Variables
--------------

| 変数名                      | 内容                                                                         |
| --------------------------- | ---------------------------------------------------------------------------- |
| common_groups               | サーバーの登録するグループを設定します                                       |
| common_users                | サーバーに登録するユーザーを設定します                                       |
| common_packages             | 共通でインストールするパッケージ名を設定します                               |
| common_ssh_port             | SSH用のポート番号を指定します                                                |
| common_ssh_use_geoip_filter | GeoIPによるSSHのフィルタリングを行うか否かを設定します                       |
| common_ssh_allow_countries  | SSHへの接続を許可する接続元の国コードを設定します                            |
| common_cron_geoip_update    | cronで実行するGeoIPデータベース更新処理の実行時刻を設定します                |
| common_requre_sudo_password | sudoでコマンドを実行する場合にパスワードの入力を必要とするか否かを設定します |
| common_fail2ban_cfg         | fail2banの設定を定義します                                                   |

### common_groups

グループの変数には以下の属性が指定できます。

| 属性名          | 必須 | 型      | 内容                                             |
| --------------- | ---- | ------- | ------------------------------------------------ |
| name            | ○    | string  |  グループ名を指定します                |
| remove          |      | boolean |  登録済みグループを削除する場合は `true`を設定します                                                |

#### Example

```
common_groups:
  - name: group_one
  - name: group_two
  - name: absent_group
    remove: yes
```

### common_users

ユーザーの変数には以下の属性が指定できます。

| 属性名          | 必須 | 型      | 内容                                             |
| --------------- | ---- | ------- | ------------------------------------------------ |
| name            | ○    | string  | ユーザー名を指定します                 |
| admin           |      | boolean | ユーザーが管理者の場合は `true` を設定します     |
| groups          |      | list    | ユーザーが所属するその他のグループを指定します |
| authorized_keys |      | list    | 公開鍵認証の公開鍵をして指定します               |
| password        |      | string  | ユーザーの暗号化済みパスワードを指定します。     |
| shell           |      | string  | ログインシェルを指定します                       |
| remove          |      | boolean |  登録済みユーザーを削除する場合は `true`を設定します                                                |

#### Example

```
common_users:
  - name: hoge
    admin: yes
    groups:
      - group_one
      - group_two
    authorized_keys:
      - https://github.com/hoge.keys
      - "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
    shell: /bin/zsh
  - name: fuga
    password: "{{ 'fugap@ssW0rd'|password_hash('sha512') }}"
    groups:
      - group_one
    authorized_keys:
      - https://github.com/fuga.keys
  - name: absent_user
    groups:
      - absent_group
    authorized_keys:
      - https://github.com/absent_user.keys
    remove: yes
```



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

### common_ssh_port

SSH用のポート番号を指定します

#### Example

```yml
common_ssh_port: 22
```

### common_ssh_use_geoip_filter

GeoIPによるSSHのフィルタリングを行うか否かを設定します

#### Example

```yml
common_ssh_use_geoip_filter: yes
```

### common_ssh_allow_countries

SSHへの接続を許可する接続元の国コードを設定します。  
※common_ssh_use_geoip_filterが`true`に設定されている場合のみ有効です

#### Example

```yml
common_ssh_allow_countries:
  - JP
  - US
```

### common_cron_geoip_update

cronで実行するGeoIPデータベース更新処理の実行時刻を設定します。  
※common_ssh_use_geoip_filterが`true`に設定されている場合のみ有効です

| 項目   | 必須 | 内容                           |
| ------ | ---- | ------------------------------ |
| hour   | ○    | cronの実行時間(時)を指定します |
| minute | ○    | cronの実行時間(分)を指定します |

#### Example

```yml
common_cron_geoip_update:
  hour: 1
  minute: 23
```

### common_requre_sudo_password

管理ユーザーがsudoでコマンド実行する場合に、パスワードの入力を必要とするか否かを設定します。  

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
