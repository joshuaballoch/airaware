namespace :deploy do
  task :symlink_database, :on_error => :continue do
    # Commented out as database.yml is removed from version control
    # run "rm #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end

before "deploy:finalize_update", "deploy:symlink_database"
after "deploy:finalize_update", "deploy:migrate"
