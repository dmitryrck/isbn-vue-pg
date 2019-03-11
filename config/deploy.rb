# encoding: utf-8
require "mina/rails"
require "mina/git"

set :application_name, "isbn-vue-pg"
set :domain, "amazon1"
set :deploy_to, "/home/ubuntu/isbn-vue-pg"
set :repository, "https://github.com/dmitryrck/isbn-vue-pg.git"
set :branch, "production"
set :user, "ubuntu"
set :sudo, true

set :docker_prefix, -> {
  %[docker run \
     --detach=false \
     -v #{fetch(:deploy_to)}:#{fetch(:deploy_to)} \
     --rm \
     --env-file #{fetch(:deploy_to)}/environment \
     -v bundle_path:/usr/local/bundle \
     -w #{fetch(:current_path)} \
     dmitryrck/ruby]
}
set :rake, -> { %[#{fetch(:docker_prefix)} /usr/local/bin/bundle exec rake ] }
set :bundle_bin, -> { %[#{fetch(:docker_prefix)} /usr/local/bin/bundle ] }

set :shared_paths, %w[vendor/bundle public/assets log app/vue/node_modules]

task setup: :remote_environment do
  command %(env DEBIAN_FRONTEND=noninteractive sudo apt-get update)
  command %(env DEBIAN_FRONTEND=noninteractive sudo apt-get install --yes docker.io)
  command %(sudo usermod -a -G docker ubuntu)

  fetch(:shared_paths).each do |path|
    command %(mkdir -p "#{fetch(:shared_path)}/#{path}")
    command %(chmod g+rx,u+rwx "#{fetch(:shared_path)}/#{path}")
  end
  command %(echo "#{File.read('.env.production')}" > #{fetch(:deploy_to)}/environment)
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'

    on :launch do
      invoke :'myapp:bundle:install'
      invoke :'myapp:vuejs'
      invoke :'rails:db_migrate'
      #invoke :'rails:assets_precompile'
      invoke :'deploy:cleanup'
      invoke :'myapp:docker'
    end
  end
end

namespace :myapp do
  namespace :bundle do
    task :install do
      command %[#{fetch(:docker_prefix)} /usr/local/bin/bundle install --path /usr/local/bundle --without development test --deployment]
    end
  end

  task :vuejs do
    comment "Building Vue.js"
    command %[docker run \
      --rm \
      -u 1000 \
      --env-file #{fetch(:deploy_to)}/environment \
      -v #{fetch(:current_path)}/app/vue:/app \
      -v #{fetch(:current_path)}/public:/app/dist \
      -w /app \
      node \
        bash -c "npm install && npm run build"]
  end

  task :docker do
    comment "Restart docker"
    command %[
      docker stop #{fetch(:application_name)} ; \
      docker rm #{fetch(:application_name)} ; \
      docker run \
        -p 5000:5000 \
        --detach=true \
        --restart=always \
        --env-file #{fetch(:deploy_to)}/environment \
        -v #{fetch(:deploy_to)}:#{fetch(:deploy_to)} \
        -v bundle_path:/usr/local/bundle \
        -w #{fetch(:current_path)} \
        --hostname="#{fetch(:application_name)}" --name="#{fetch(:application_name)}" \
      dmitryrck/ruby bundle exec puma -p 5000
    ]
  end
end
