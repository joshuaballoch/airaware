desc "Invoke a rake task on the remote servers. Usage: cap staging invoke_rake task=your-task-name"
task :invoke_rake do
  run "cd #{deploy_to}/current; /usr/bin/env bundle exec rake RAILS_ENV=#{rails_env} #{ENV['task']}"
end
