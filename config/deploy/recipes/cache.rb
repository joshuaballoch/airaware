namespace :cache do
  desc 'clear cache'
  task :clear, roles: :app do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake tmp:cache:clear"
  end
end

after 'deploy:start', 'cache:clear'
