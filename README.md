# infra

姫路IT系勉強会で利用するインフラ周りのコードを管理しています


ディレクトリ構成
---------------------------

### packer

Packerの設定ファイルやイメージの生成に必要なファイルを格納しています

### terraform

以下の管理用のファイルを格納しています

* ドメイン

### provision

サーバーの構成管理用のファイルを格納しています。
Ansibleを利用しサーバーの構成を管理しています。


環境変数について
---------------------------

このリポジトリの内容を利用するには
以下の環境変数を設定しておく必要があります

| 環境変数名         | 内容                                     |
| ------------------ | ---------------------------------------- |
| VAGRANTCLOUD_TOKEN | [Vagrant Cloud][vagrant_cloud]のトークン |
| CLOUDFLARE_EMAIL   | [Cloudflare][cloudflare]のアカウント                   |
| CLOUDFLARE_TOKEN   | [Cloudflare][cloudflare]のAPIトークン                  |

[vagrant_cloud]: https://app.vagrantup.com/histudy
[cloudflare]: https://www.cloudflare.com/
