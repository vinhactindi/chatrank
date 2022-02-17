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
    Member ranking by message number Discord bot
    <br />
    * * *
    <br />
    <a href="https://github.com/vinhactindi/chatrank">Demo</a>
    ·
    <a href="https://github.com/vinhactindi/chatrank/issues">Report Bugs</a>
    ·
    <a href="https://github.com/vinhactindi/chatrank/issues">Request Features</a>
    <br />
    or
    <br />
    Read this document in 
    <a href="https://github.com/vinhactindi/chatrank/blob/main/README.md">日本語</a>
  </p>
</div>

## About

ChatRank is a self-made service at the Fjord Bootcamp.

> 今月の発言数の合計と発言者数の多いチャットユーザーのランキングを知る。

## Built with

* [Ruby](https://www.ruby-lang.org/) 3.0.2
* [Ruby on Rails](https://rubyonrails.org/) 6.1.4
* [React.js](https://reactjs.org/) 17.0.2

## Features

* Discord server manager can get monthly statistics on history messages.

## Usage

### Login

* Login with Discord Account

![Login](/app/assets/images/usage-login.png)

### Bot inviting

* Click on「サーバーにbotを招待する」or「ボットを招待」to invite `chatrank` bot to your Discord server

![Bot invite](/app/assets/images/usage-bot-invite.png)

### Servers and channels list updating

* When you log in to the `chatrankbot` website for the first time, you may not see your server or channel, click on **サーバー**and**チャンネル**'s input to update your servers and channels list.

![Upate server and channel list](/app/assets/images/usage-update.png)

### Read history messages

* *If you don't want to rank members by historical messages, you don't need to worry about this feature*
* Make sure you are the manager and you did update your servers and channels list
* Click on **過去統計** to make this feature work
* Depending on the number of messages in the server, the process will take longer (20m to ~h)
* Please consider when using this feature


![Read History Messages](/app/assets/images/usage-read-history-messages.png)

## Development

### Discord application creating

* Create an Application at https://discord.com/developers/applications/

#### Bot setting

* Create a bot with `Developer Portal` and set` Token` to an environment variable

#### OAuth2 setting

* Set the redirect URL in `Developer Portal / OAuth2 / Redirects`
* Set `Client ID` and` Client Secret` in environment variables


### Environment variables

| Environment variables | Explanation                               |
| --------------------- | ----------------------------------------- |
| DISCORD_BOT_TOKEN     | Botの `Token`                              |
| DISCORD_CLIENT_ID     | OAuth2の `Client ID`                       |
| DISCORD_CLIENT_SECRET | OAuth2の `Client Secret`                   |

### Installation

```
$ bin/rails setup
```

### Execution

```
$ bin/rails serve
```

### Bot

```
$ bin/rails bot:run
```

### Test

```
$ bin/rails test:all
```

### Lint

```
$ bin/lint
```

## Heroku deploy notice

### `worker bin/rail bot:run`

デフォルトでは、herokuは `web` のdynoのみを実行します。アプリの全機能については、`worker` のdynoを有効にしてください。

> Personal accounts are given a base of 550 free dyno hours each month. In addition to these base hours, accounts which verify with a credit card will receive an additional 450 hours added to the monthly free dyno quota. This means you can receive a total of 1000 free dyno hours per month, if you verify your account with a credit card.
>
> -- https://devcenter.heroku.com/articles/free-dyno-hours#free-dyno-hour-pool


### Dyno sleeping

> If an app has a free web dyno, and that dyno receives no web traffic in a 30-minute period, it will sleep. In addition to the web dyno sleeping, the worker dyno (if present) will also sleep.
> Free web dynos do not consume free dyno hours while sleeping.
>
> -- https://devcenter.heroku.com/articles/free-dyno-hours#dyno-sleeping



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
