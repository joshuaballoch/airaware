require 'capistrano-unicorn'
set :unicorn_bin, 'unicorn_rails'
after 'deploy:restart', 'unicorn:restart'
