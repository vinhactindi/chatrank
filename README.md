<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/vinhactindi/chatrank">
    <img src="app/assets/images/chatrank.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center">Chat Rank</h3>

  <p align="center">
    Discordの中で最もメッセージが多いのは誰かを確認するのに役立ちます
    <br />
    * * *
    <br />
    <a href="https://github.com/vinhactindi/chatrank">デモ</a>
    ·
    <a href="https://github.com/vinhactindi/chatrank/issues">バグの報告</a>
    ·
    <a href="https://github.com/vinhactindi/chatrank/issues">機能のリクエスト</a>
    <br />
    <br />
    このドキュメントを
    <a href="https://github.com/vinhactindi/chatrank/blob/main/README.en.md">English</a>
    で読みたいですか？
  </p>
</div>

## 概要

ChatRank はフィヨルドブートキャンプで自作サービスです。

> 今月の発言数の合計と発言者数の多いチャットユーザーのランキングを知る。

## 開発環境

* [Ruby](https://www.ruby-lang.org/) 3.0.2
* [Ruby on Rails](https://rubyonrails.org/) 6.1.4
* [React.js](https://reactjs.org/) 17.0.2

## 機能概要

* Discordのサーバーの管理者は過去のメッセージが月次統計できます。

## 利用方法

### ログイン

* Discordのアカウントでログインします

![Login](/app/assets/images/usage-login.png)

### Botを招待

* 「サーバーにbotを招待する」または、「ボットを招待」をクリックしてください

![Bot invite](/app/assets/images/usage-bot-invite.png)

### サーバーとチャンネルの一覧を更新

* 初めてログインしたときは、サーバーは表示されませんので、**サーバー**と**チャンネル**のinputで「更新」をクリックしてください

![Upate server and channel list](/app/assets/images/usage-update.png)

### 発言の集計をする

* *過去のメッセージでメンバーをランク付けする必要がない場合は、この機能を気にしないでください*
* サーバーとチャンネルの一覧を更新した後、サーバーの管理者として発言の集計ができます
* 「発言の集計をする」をクリックしたら、確認してください
* サーバーに大量のメッセージがある場合、プロセスにはかなりの時間がかかります（多分20分から数時間）・統計中にリーダーボードが表示しません
* この機能は必要な場合にのみ使用してください


![Read History Messages](/app/assets/images/usage-read-history-messages.png)

### リーダーボード

* ホームページにアクセスしてランキングを確認するか、`chatrank!leaderboard` をチャンネルに送信してください（詳細については、`chatrank!help` を参照してください）

![Commands Bot](/app/assets/images/usage-commands.png)

## 開発

### DiscordのApplicationの作成

* https://discord.com/developers/applications/ でApplicationを作成

#### Botの設定

* `Developer Portal` でBotを作成し、`Token` を環境変数に設定する

#### OAuth2の設定

* `Developer Portal / OAuth2 / Redirects` にリダイレクトURLを設定する
* `Client ID` と `Client Secret` を環境変数に設定する


### 環境変数の設定

| 環境変数名             | 説明                                      |
| --------------------- | ----------------------------------------- |
| DISCORD_BOT_TOKEN     | Botの `Token`                               |
| DISCORD_CLIENT_ID     | OAuth2の `Client ID`                         |
| DISCORD_CLIENT_SECRET | OAuth2の `Client Secret`                     |

### インストール

```
$ bin/rails setup
```

### 実行

```
$ bin/rails serve
```

### Bot

```
$ bin/rails bot:run
```

### テスト

```
$ bin/rails test:all
```

### リント

```
$ bin/lint
```

## Herokuにデプロイ

### デプロイ

[![Deploy](https://www.herokucdn.com/deploy/button.svg)][heroku-deploy-url]

### `worker bin/rail bot:run`

デフォルトでは、herokuは `web` のdynoのみを実行します。アプリの全機能については、`worker` のdynoを有効にしてください。

> 個人のアカウントには、月ごとに 550 時間の基本の Free dyno 時間が割り当てられています。この基本の時間のほかに、クレジットカードで認証を行っている​アカウントには、月単位の​ Free dyno 割り当てに 450 時間が追加されます。 つまり、アカウントをクレジットカードで認証しているユーザーには、月ごとに合計で 1000 Free dyno 時間が割り当てられます。
>
> -- https://devcenter.heroku.com/ja/articles/free-dyno-hours#free-dyno-hour-pool


### dyno のスリープ

> アプリに Free Web dyno があり、その dyno が 30 分間 Web トラフィックを受信しない場合、その dyno は休眠状態​になります。 Web dyno のスリープに加えて、Worker dyno (存在する場合) も​スリープします。
> Free Web dyno は休眠中、Free dyno 時間を消費しません。
>
> -- https://devcenter.heroku.com/ja/articles/free-dyno-hours#dyno-sleeping



![Heroku Dynos](/app/assets/images/heroku-dynos.png)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/vinhactindi/chatrank.svg?style=for-the-badge
[contributors-url]: https://github.com/vinhactindi/chatrank/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/vinhactindi/chatrank.svg?style=for-the-badge
[forks-url]: https://github.com/vinhactindi/chatrank/network/members
[stars-shield]: https://img.shields.io/github/stars/vinhactindi/chatrank.svg?style=for-the-badge
[stars-url]: https://github.com/vinhactindi/chatrank/stargazers
[issues-shield]: https://img.shields.io/github/issues/vinhactindi/chatrank.svg?style=for-the-badge
[issues-url]: https://github.com/vinhactindi/chatrank/issues
[license-shield]: https://img.shields.io/github/license/vinhactindi/chatrank.svg?style=for-the-badge
[license-url]: https://github.com/vinhactindi/chatrank/blob/master/LICENSE.txt
[heroku-deploy-url]: https://heroku.com/deploy?template=https://github.com/vinhactindi/chatrank
