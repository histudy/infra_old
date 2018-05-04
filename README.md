# infra

histudy/infraでは、姫路IT系勉強会が主催している姫路IT系勉強会、

加古川IT系インフラ勉強会のサーバを管理するためのインフラ周りのコードを管理しています。

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

roles以下の各ディレクトリは、それぞれ独立したリポジトリで管理しています。

| role ディレクトリ                |
| -------------------------------- |
| [apt-backports][apt-backports]   |
| [common][common]                 |
| [dehydrated][dehydrated]         |
| [lexicon][lexicon]               |
| [mackerel-agent][mackerel-agent] |
| [nginx][nginx]                   |
| [python][python]                 |

その他のロールについては、 [ansible-role](https://github.com/histudy?q=ansible-role) で検索すると見つけやすいです。

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
[apt-backports]: https://github.com/histudy/ansible-role-apt-backports
[common]: https://github.com/histudy/ansible-role-common
[dehydrated]: https://github.com/histudy/ansible-role-dehydrated
[lexicon]: https://github.com/histudy/ansible-role-lexicon
[mackerel-agent]: https://github.com/histudy/ansible-role-mackerel-agent
[nginx]: https://github.com/histudy/ansible-role-nginx
[python]: https://github.com/histudy/ansible-role-python
