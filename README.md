php
=========

[php](http://php.net/)のインストールとセットアップを行います。

Role Variables
--------------

### php_default_version

デフォルトで利用するPHPのバージョンを指定します。

#### Example

```yaml
php_default_version: "7.0"
```

### php_packages

インストールするPHPのパッケージを指定します。

#### Example

```yaml
php_packages:
  - php{{ php_default_version }}-common
  - php{{ php_default_version }}-json
  - php{{ php_default_version }}-opcache
  - php{{ php_default_version }}-readline
  - php{{ php_default_version }}-cli
  - php{{ php_default_version }}-dev
  - php{{ php_default_version }}-curl
  - php{{ php_default_version }}-mbstring
  - php{{ php_default_version }}-sqlite3
  - php{{ php_default_version }}-gd
  - php{{ php_default_version }}-mysql
  - php{{ php_default_version }}-xml
  - php{{ php_default_version }}-bz2
  - php{{ php_default_version }}-zip
  - php{{ php_default_version }}-fpm
```
### php_fpm_package_name

php-fpmのパッケージ名を指定します。  
`php_packages`変数にこの変数で指定されたパッケージが含まれている場合は、  
`php_fpm_package_name`変数で指定されたサービスを有効化します。

#### Example

```yaml
php_fpm_package_name: php{{ php_default_version }}-fpm
```

### php_fpm_service_name

php-fpmのサービス名を指定します。  
`php_packages`変数に`php_fpm_package_name`変数で指定されたパッケージが含まれている場合は、   
この変数で指定されたサービスを有効化します。


#### Example

```yaml
php_fpm_service_name: php{{ php_default_version }}-fpm
```

### php_ini_dir

php.iniが格納されているディレクトリ名を指定します。

#### Example

```yaml
php_ini_dir: /etc/php/{{ php_default_version }}
```

### php_composer_install

[composer](https://getcomposer.org/)をインストールする否かを指定します。

#### Example

```yaml
php_composer_install: yes
```

### php_ini_cli_cfg

コマンドライン版のphpの設定を定義します。

### php_ini_fpm_cfg

php-fpmのPHPの設定を定義します。

### php_ini_apache2_cfg

Apache + mod_phpのPHPの設定を定義します。

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
     - { role: php }
```

License
-------

MIT
