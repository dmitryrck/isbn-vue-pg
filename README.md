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
