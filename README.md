nginx
=========

[Nginx](https://nginx.org/)のインストールとセットアップを行います

Role Variables
--------------

| 変数名                | 内容                                                   |
| --------------------- | ------------------------------------------------------ |
| nginx_packages        | インストールするNginxのパッケージを設定します          |
| nginx_cfg             | httpディレクティブの内容を設定します                   |
| nginx_vhosts          | serverディレクティブの内容を設定します                 |
| nginx_generate_dh_key | Diffie-Hellman鍵共有用の鍵を生成するか否かを設定します |
| nginx_dh_key_bit      | Diffie-Hellman鍵のサイズを設定します                   |
| nginx_dh_key_path     | Diffie-Hellman鍵の保存先を設定します                   |

### nginx_packages

インストールするNginxのパッケージを設定します。

#### Example

```yml
nginx_packages:
  - nginx
```

### nginx_cfg

httpディレクティブの内容を設定します。

#### Example

```yml
nginx_cfg:
  user: "www-data"
  worker_processes: auto
  pid: /run/nginx.pid
  events:
    worker_connections: 1024
  http:
    sendfile: yes
    tcp_nopush: yes
    tcp_nodelay: yes
    keepalive_timeout: 65
    types_hash_max_size: 2048
    server_tokens: no
    default_type: "application/octet-stream"
    access_log: /var/log/nginx/access.log
    error_log: /var/log/nginx/error.log
    client_max_body_size: 8M
    gzip: yes
    gzip_vary: yes
    gzip_proxied: any
    gzip_comp_level: 6
    gzip_buffers: "16 8k"
    gzip_http_version: 1.1
    gzip_types:
      - text/plain
      - text/css
      - application/json
      - application/javascript
      - text/xml
      - application/xml
      - application/xml+rss
      - text/javascript
```

### nginx_vhosts

serverディレクティブの内容を設定します。

#### Example

※以下、指定可能な全項目の設定例です

```yml
nginx_vhosts:
  - name: default
    default: yes
    server_name: www.exampe.com
    # server_name:
    #   - exampe.com
    #   - "*.exampe.com"
    access_log: /var/log/nginx/access.log
    error_log: /var/log/nginx/error.log
    document_root: /var/www/html
    client_max_body_size: 16M
    index: index.html
    # index:
    #   - index.html
    #   - index.htm
    #   - index.php
    variables:
      variable_name: varriable_value
    includes:
      - snippets/wordpress.conf
    locations:
      - pattern: "/\\.ht"
        match_type: "~"
        content: "deny all;"
    ssl:
      certificate: /path/to/cert.pem
      certificate_key:  /path/to/privkey.pem
      trusted_certificate: /path/to/chain.pem
      protocols:
        - TLSv1.2
      ciphers:
        - ECDHE-ECDSA-AES256-GCM-SHA384
        - ECDHE-RSA-AES256-GCM-SHA384
        - ECDHE-ECDSA-CHACHA20-POLY1305
        - ECDHE-RSA-CHACHA20-POLY1305
        - ECDHE-ECDSA-AES128-GCM-SHA256
        - ECDHE-RSA-AES128-GCM-SHA256
        - ECDHE-ECDSA-AES256-SHA384
        - ECDHE-RSA-AES256-SHA384
        - ECDHE-ECDSA-AES128-SHA256
        - ECDHE-RSA-AES128-SHA256
      session_timeout: "1d"
      session_cache: "shared:SSL:50m"
      session_tickets: no
      hsts: "max-age=15768000; includeSubDomains;"
      stapling: yes
      stapling_verify: yes
    extra_setting: |
      # some extra setting here
```

### nginx_generate_dh_key

Diffie-Hellman鍵共有用の鍵を生成するか否かを設定します。

#### Example

```yml
nginx_generate_dh_key: yes
```

### nginx_dh_key_bit

Diffie-Hellman鍵のサイズを設定します。  
※nginx_generate_dh_keyに`true`が設定されている場合のみ有効です。

#### Example

```yml
nginx_dh_key_bit: 2048
```

### nginx_dh_key_path

Diffie-Hellman鍵の保存先を設定します。  
※nginx_generate_dh_keyに`true`が設定されている場合のみ有効です。

#### Example

```yml
nginx_dh_key_path: /etc/nginx/dhparam.pem
```

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
