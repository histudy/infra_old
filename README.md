# infra

histudy/infraでは、姫路IT系勉強会が主催している姫路IT系勉強会、加古川IT系インフラ勉強会のサーバを管理するためのインフラ周りのコードを管理しています。

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

### provision

サーバーの構成管理用のファイルを格納しています。

Ansibleを利用しサーバーの構成を管理しています。

環境変数について
---------------------------

このリポジトリの内容を利用するには以下の環境変数を設定しておく必要があります。

| 環境変数名         | 内容                                     |
| ------------------ | ---------------------------------------- |
| VAGRANTCLOUD_TOKEN | [Vagrant Cloud][vagrant_cloud]のトークン |
| CLOUDFLARE_EMAIL   | [Cloudflare][cloudflare]のアカウント     |
| CLOUDFLARE_TOKEN   | [Cloudflare][cloudflare]のAPIトークン    |
| MACKEREL_API_KEY   | [Mackerel][mackerel]のAPIキー            |

[vagrant_cloud]: https://app.vagrantup.com/histudy/
[cloudflare]: https://www.cloudflare.com/
[mackerel]: https://mackerel.io/
[histudy]: https://histudy.jp/
