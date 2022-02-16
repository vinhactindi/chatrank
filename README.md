<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://chatrankbot.herokuapp.com)


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

### DiscordのApplicationの作成

作成中

### 環境変数の設定

| 環境変数名             | 説明                                      |
| --------------------- | ----------------------------------------- |
| DISCORD_BOT_TOKEN     | BotのToken                                |
| DISCORD_CLIENT_ID     | OAuth2のClient ID                         |
| DISCORD_CLIENT_SECRET | OAuth2のClient Secret                     |

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

作成中

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
