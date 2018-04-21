dehydrated
=========

dehydratedのインストールとセットアップを行います

Role Variables
--------------

| 変数名                            | 内容                                                             |
| --------------------------------- | ---------------------------------------------------------------- |
| dehydrated_cfg                    | dehydratedの設定内容を定義します                                 |
| dehydrated_domains                | Let's Encryptで証明書を取得するドメインを定義します              |
| dehydrated_auto_execute           | プロビジョニング実行時にdehydratedの実行を行うか否かを指定します |
| dehydrated_cron                   | cronで実行する証明書更新処理の実行時刻を設定します               |
| dehydrated_hook_initialize        | フックスクリプトの初期化処理を定義します                         |
| dehydrated_hook_deploy_challenge  | deploy_challengeフック呼び出し時の実行内容を定義します           |
| dehydrated_hook_clean_challenge   | clean_challengeフック呼び出し時の実行内容を定義します            |
| dehydrated_hook_deploy_cert       | deploy_certフック呼び出し時の実行内容を定義します                |
| dehydrated_hook_unchanged_cert    | unchanged_certフック呼び出し時の実行内容を定義します             |
| dehydrated_hook_invalid_challenge | invalid_challengeフック呼び出し時の実行内容を定義します          |
| dehydrated_hook_request_failure   | request_failureフック呼び出し時の実行内容を定義します            |
| dehydrated_hook_generate_csr      | generate_csrフック呼び出し時の実行内容を定義します               |
| dehydrated_hook_startup_hook      | startup_hookフック呼び出し時の実行内容を定義します               |
| dehydrated_hook_exit_hook         | exit_hookフック呼び出し時の実行内容を定義します                  |

### dehydrated_cfg

dehydratedの設定内容を定義します

#### Example

```yml
dehydrated_cfg:
  user: ""
  group: ""
  ca: https://acme-v02.api.letsencrypt.org/directory
  oldca: ""
  challengetype: http-01
  keysize: 4096
  openssl_cnf:
  openssl: openssl
  curl_opts: ""
  hook_chain: no
  renew_days: 30
  private_key_renew: yes
  private_key_rollover: no
  key_algo: rsa
  contact_email: ""
  ocsp_must_staple: no
  ocsp_fetch: no
  auto_cleanup: no
  api: auto
```

### dehydrated_domains

Let's Encryptで証明書を取得するドメインを定義します

#### Example

```yml
dehydrated_domains:
    - name: example.com
      domains:
        - example.com
        - www.example.com
    - name: example.net
      domains: example.net
```

### dehydrated_auto_execute

プロビジョニング実行時にdehydratedの実行を行うか否かを指定します

#### Example

```yml
dehydrated_auto_execute: yes
```

### dehydrated_cron

cronで実行する証明書更新処理の実行時刻を設定します

#### Example

```yml
dehydrated_cron:
  hour: "{{ 23|random }}"
  minute: "{{ 59|random }}"
```

### dehydrated_hook_initialize

フックスクリプトの初期化処理を定義します

#### Example

```yml
dehydrated_hook_initialize: |
    export PROVIDER=${PROVIDER:-"cloudflare"}
```

### dehydrated_hook_deploy_challenge

deploy_challengeフック呼び出し時の実行内容を定義します

#### Example

```yml
dehydrated_hook_deploy_challenge: |
    lexicon $PROVIDER create ${DOMAIN} TXT --name="_acme-challenge.${DOMAIN}." --content="${TOKEN_VALUE}"
```

### dehydrated_hook_clean_challenge

clean_challengeフック呼び出し時の実行内容を定義します

#### Example

```yml
dehydrated_hook_clean_challenge: |
    lexicon $PROVIDER delete ${DOMAIN} TXT --name="_acme-challenge.${DOMAIN}." --content="${TOKEN_VALUE}"
```

### dehydrated_hook_deploy_cert

deploy_certフック呼び出し時の実行内容を定義します

### dehydrated_hook_unchanged_cert

unchanged_certフック呼び出し時の実行内容を定義します

### dehydrated_hook_invalid_challenge

invalid_challengeフック呼び出し時の実行内容を定義します

### dehydrated_hook_request_failure

request_failureフック呼び出し時の実行内容を定義します

### dehydrated_hook_generate_csr

generate_csrフック呼び出し時の実行内容を定義します

### dehydrated_hook_startup_hook

startup_hookフック呼び出し時の実行内容を定義します

### dehydrated_hook_exit_hook

exit_hookフック呼び出し時の実行内容を定義します

Dependencies
------------

* [apt-backports](https://github.com/histudy/ansible-role-apt-backports)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
     - { role: dehydrated }
```

License
-------

MIT
