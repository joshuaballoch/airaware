set :user,      "deploy"
set :deploy_to, "/var/www/airaware"

set :branch, "master"
set :rails_env, "production"
set :app_env, "production"
set :unicorn_env, "production"
set :unicorn_restart_sleep_time, 120

role :app, "128.199.168.239"
role :web, "128.199.168.239"
role :db, "128.199.168.239", :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
