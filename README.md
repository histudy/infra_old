# infra

姫路IT系勉強会で利用するインフラ周りのコードを管理しています。

環境
---------------------------

### OS

Debian 9(stretch)

ディレクトリ構成
---------------------------

### packer

Packerの設定ファイルやイメージの生成に必要なファイルを格納しています。

### terraform

以下の管理用のファイルを格納しています。

* ドメイン
* リポジトリ

### provision

サーバーの構成管理用のファイルを格納しています。
Ansibleを利用しサーバーの構成を管理しています。

### ロール一覧

勉強会で作成しているAnsibleのロールは以下の通りです。

### 利用中

* [apt-backports](https://github.com/histudy/ansible-role-apt-backports)
* [common](https://github.com/histudy/ansible-role-common)
* [dehydrated](https://github.com/histudy/ansible-role-dehydrated)
* [lexicon](https://github.com/histudy/ansible-role-lexicon)
* [mackerel-agent](https://github.com/histudy/ansible-role-mackerel-agent)
* [mariadb](https://github.com/histudy/ansible-role-mariadb)
* [nginx](https://github.com/histudy/ansible-role-nginx)
* [php](https://github.com/histudy/ansible-role-php)
* [python](https://github.com/histudy/ansible-role-python)

### 未使用

* [nodejs](https://github.com/histudy/ansible-role-nodejs)
* [ruby](https://github.com/histudy/ansible-role-ruby)
* [redmine](https://github.com/histudy/ansible-role-redmine)
* [fluentd](https://github.com/histudy/ansible-role-fluentd)
* [minecraft-server](https://github.com/histudy/ansible-role-minecraft-server)

環境変数について
---------------------------

このリポジトリの内容を利用するには以下の環境変数を設定しておく必要があります。

| 環境変数名         | 内容                                     | 利用箇所(ディレクトリ) |
| ------------------ | ---------------------------------------- | ---------------------- |
| VAGRANTCLOUD_TOKEN | [Vagrant Cloud][vagrant_cloud]のトークン | packer                 |
| CLOUDFLARE_EMAIL   | [Cloudflare][cloudflare]のアカウント     | terraform / provision  |
| CLOUDFLARE_TOKEN   | [Cloudflare][cloudflare]のAPIトークン    | terraform / provision  |
| MACKEREL_API_KEY   | [Mackerel][mackerel]のAPIキー            | provision              |
| VAULT_ADDR         | [Vault][vault]のサーバーアドレス         | provision              |
| VAULT_TOKEN        | [Vault][vault]のトークン                 | provision              |

[vagrant_cloud]: https://app.vagrantup.com/histudy
[cloudflare]: https://www.cloudflare.com/
[mackerel]: https://mackerel.io/
[vault]: https://www.vaultproject.io/
