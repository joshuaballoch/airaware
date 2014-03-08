# overwrite assets:precompile task to use local compile and upload them to server

# namespace :deploy do
#   namespace :assets do
#     desc "Run assets procompilation locally and then upload the complied assets to servers."
#     task :precompile, :roles => :web, :except => {:no_release => true} do
#       from = source.next_revision(current_revision)

#       if capture("cd #{latest_release} && #{source.local.log(from)} app/assets/ lib/assets/ vendor/assets/ | wc -l").to_i > 0
#         run_locally "RAILS_ENV=#{rails_env} bundle exec rake assets:clean"
#         run_locally "RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
#         run_locally "cd public && tar -jcf assets.tar.bz2 assets"
#         top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
#         run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
#         run_locally "rm public/assets.tar.bz2"
#         run_locally "RAILS_ENV=#{rails_env} bundle exec rake assets:clean"
#       else
#         logger.info "Skipping assets precompilation cause there is no asset changes"
#       end
#     end
#   end
# end

namespace :assets do
  desc "Create a symlink for application.css and application.js (used by static pages)"
  task :static, :roles => :web, :on_error => :continue do
    %w(application.css application.js).each do |asset|
      file = capture "cd #{shared_path}/assets && ruby -ryaml -e 'p YAML.load_file(\"manifest.yml\")[\"#{asset}\"]'"
      run "cd #{shared_path}/assets && ln -sf #{file.chomp} #{asset}"
    end
  end

  task :clean_expired, :roles => :web, :on_error => :continue do
    run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:clean_expired}
  end
end

after "deploy:assets:precompile", "assets:static"

after "deploy:assets:precompile", "assets:clean_expired"
