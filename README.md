[![Netlify Status](https://api.netlify.com/api/v1/badges/a2d42b63-cf82-4036-aef9-5bff665a60d8/deploy-status)](https://app.netlify.com/sites/is-serene-pike-44524c/deploys)
[![Build Status](https://semaphoreci.com/api/v1/dmitryrck/isbn-vue-pg/branches/master/badge.svg)](https://semaphoreci.com/dmitryrck/isbn-vue-pg)
[![Maintainability](https://api.codeclimate.com/v1/badges/27d30b06432f4211f397/maintainability)](https://codeclimate.com/github/dmitryrck/isbn-vue-pg/maintainability)

# isbn-vue-pg

This is a sample project to test integration between Vue.js and a Rails api.

## Vue.js

The source of the Vue.js project is at `app/vue`. It is a stand-alone nodejs app with webpack.

## Rails

Everything else is a regular Ruby on Rails application.

## Setup

### Rails

```terminal
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rails server
```

The rails project is an api.

### Vue.js

```terminal
$ cd app/vue
$ npm install
$ npm run dev
```

Visit the url informed.

## Setup using docker

```terminal
$ cp docker-compose.yml.sample docker-compose.yml
$ cp config/database.yml.sample config/database.yml
$ docker-compose up app vue
```

By default you can access your project in [localhost:4000](http://localhost:4000).

## Deploy

### Current Status

This repo is configured to deploy the `production` branch to [netlify.com](https://netlify.com) and [heroku.com](https://heroku.com).

* Netlify: [https://is-serene-pike-44524c.netlify.com/](https://is-serene-pike-44524c.netlify.com/)
* Heroku: [https://obscure-cliffs-13669.herokuapp.com/](https://obscure-cliffs-13669.herokuapp.com/)

The heroku server will work only as a backend api because it is not compiling the Vue.js project.

### Mina (Similar to capistrano)

There is also a `config/deploy.rb` file to deploy using mina (very similar to capistrano).

1. [Install ruby](https://blog.codeminer42.com/4-5-ways-to-install-ruby-in-userspace-d26b0ba43610) and nodejs.
2. Add a user and configure it to use `sudo systemctl`
3. Edit the systemd file `/etc/systemd/system/rails.service`:

```
[Unit]
Description="Rails app"
Requires=network-online.target
After=network-online.target

[Service]
Environment="RAILS_ENV=production"
EnvironmentFile=/etc/environment
Type=simple
User=myuser
Group=myuser
WorkingDirectory=/home/myuser/isbn-vue-pg/current
ExecStart=/usr/local/bin/bundle exec rails server -p 3000
TimeoutSec=30
RestartSec=15s
Restart=always

[Install]
WantedBy=multi-user.target
```

Note: Don't forget to change `myuser` to your user.

Run:

```terminal
$ systemctl daemon-reload && systemctl enable rails.service
```

To enable to `rails.service` unit.

4. Run `mina setup` to create the initial files.
5. Edit `/etc/environment` (in the server) with something similar to this:

```
DATABASE_URL=postgres://username:password@host:5432/database
API_URL=/
RAILS_SERVE_STATIC_FILES=true
```

Or (recommended) follow the [Rails guides](https://guides.rubyonrails.org/security.html#environmental-security) to setup your master.key.

6. And deploy with:

```
$ mina deploy
```

## TODO or not TODO

This is a proof of concept app, as such:

* Security and api call rate is not a concern
* There are some code to refactory:
  - The error message is not the same as the backend reply
  - It would be nice to translate it
