set :user,      "deploy"
set :deploy_to, "/var/www/airaware"

set :branch, "master"
set :rails_env, "production"
set :app_env, "production"
set :unicorn_env, "production"
set :unicorn_restart_sleep_time, 120

role :app, "42.62.50.104"
role :web, "42.62.50.104"
role :db, "42.62.50.104", :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
