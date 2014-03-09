set :user,      "deploy"
set :deploy_to, "/var/www/airaware"

set :branch, "master"
set :rails_env, "staging"
set :app_env, "staging"
set :unicorn_env, "staging"
set :unicorn_restart_sleep_time, 120

role :app, "42.62.56.34"
role :web, "42.62.56.34"
role :db, "42.62.56.34", :primary => true

ssh_options[:port] = 22
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
