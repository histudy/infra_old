# infra

## このリポジトリについて

[姫路IT系勉強会](https://histudy.jp/)で利用するインフラ周りの管理をコード化しています。

## 姫路IT系勉強会とは？

**[姫路IT系勉強会](https://histudy.jp/)** は、兵庫県姫路市を中心とした周辺地域のIT系技術者、Webデザイナー、学生、それらの技術に興味を持つ人々が気軽に集まり交流できる勉強会です。

2012年から始まった勉強会は、参加者それぞれが「話を聞いてみたいこと」「話をしたいこと」を持ち寄って話をするという勉強会スタイルで毎月開催しています。

勉強会の開催以外にも、学生のIT系イベント参加に必要となる交通費や参加費の補助なども検討するなど、学生への支援も進めています。

「姫路IT系勉強会」のほかにも、インフラに特化した「加古川IT系インフラ勉強会」も毎月開催しています。

過去の勉強会で話をした内容などは、当日、[HackMD](https://hackmd.io/)を利用して参加者全員で作成したログを[勉強会のホームページ](https://hisutdy.jp/)で公開していますので、興味のある方は、ぜひ一度ご参加ください！

開催案内は、[Connpass](https://histudy.connpass.com/)や[TwitterのBotアカウント](https://twitter.com/himeji_study/)で案内していますので、こちらをご確認ください。

## 環境について

### OS

Debian 9 (stretch)

## ディレクトリ構成

### packer

Packerの設定ファイルやイメージの生成に必要なファイルを格納しています。

### terraform

以下の管理用のファイルを格納しています。

* ドメイン
* リポジトリ

利用方法については、 [provisionフォルダ内のREADME](provision/README.md) を参照してください。

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

## 環境変数について

このリポジトリの内容を利用するには以下の環境変数を設定しておく必要があります。

| 環境変数名         | 内容                                     | 利用箇所(ディレクトリ) |
| ------------------ | ---------------------------------------- | ---------------------- |
| VAGRANTCLOUD_TOKEN | [Vagrant Cloud][vagrant_cloud]のトークン | packer                 |
| CLOUDFLARE_EMAIL   | [Cloudflare][cloudflare]のアカウント     | terraform / provision  |
| CLOUDFLARE_TOKEN   | [Cloudflare][cloudflare]のAPIトークン    | terraform / provision  |
| MACKEREL_API_KEY   | [Mackerel][mackerel]のAPIキー            | provision              |
| SACLOUD_API_KEY    | [Sakura Cloud][sakura_cloud]のAPIキー    | terraform / provision  |

[vagrant_cloud]: https://app.vagrantup.com/histudy
[cloudflare]: https://www.cloudflare.com/
[mackerel]: https://mackerel.io/
[sakura_cloud]: https://cloud.sakura.ad.jp/

## ライセンス

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
