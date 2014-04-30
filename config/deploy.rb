set :stages, %w(staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require "bundler/capistrano"
require "sidekiq/capistrano2"

# Include Thinking sphinx on deploy when incorporate in app
# require 'thinking_sphinx/deploy/capistrano'

set :bundle_cmd, "bundle"
set :bundle_without,  [:test, :development, :darwin_development, :linux_development]
set :deploy_via, :remote_cache
set :application, "airaware"
set :repository,  "git@github.com:joshuaballoch/airaware.git"
set :scm, :git
set :user, :deploy
set :use_sudo, false
set :git_enable_submodules, true

# Use forward_agent to let the server use the local ssh keys to connect to github, instead of needing to put it onto the server
set :ssh_options, {:forward_agent => true}

load 'config/deploy/recipes/rvm'
load 'config/deploy/recipes/depends'
load 'config/deploy/recipes/database'
load 'config/deploy/recipes/unicorn'
load 'config/deploy/recipes/assets'
load 'config/deploy/recipes/rake'
load 'config/deploy/recipes/cache'
