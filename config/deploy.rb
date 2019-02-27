require "mina/rails"
require "mina/git"

set :application_name, "isbn-vue-pg"
set :domain, "isbn.server"
set :deploy_to, "/home/myuser/isbn-vue-pg"
set :repository, "https://github.com/dmitryrck/isbn-vue-pg.git"
set :branch, "production"
set :user, "myuser"

set :shared_paths, %w[log tmp app/vue/node_modules]

task setup: :remote_environment do
  fetch(:shared_paths).each do |path|
    command %(mkdir -p "#{fetch(:shared_path)}/#{path}")
    command %(chmod g+rx,u+rwx "#{fetch(:shared_path)}/#{path}")
  end
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'build:vue'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{systemctl daemon-reload && systemctl restart rails.service}
      end
    end
  end
end

namespace :build do
  task :vue do
    command %{echo " -----> Build vuejs"}
    command %{ln -s #{fetch(:shared_path)}/app/vue/node_modules app/vue/node_modules}
    command %{cd app/vue}
    command %{npm install >/dev/null 2>/dev/null}
    command %{npm run build >/dev/null 2>/dev/null}
    command %{cd ../..}
    command %{mv app/vue/dist/* public}
  end
end
