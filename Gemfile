#source 'https://rubygems.org'
source 'http://ruby.taobao.org/'

gem 'rails', '3.2.17'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Slim for slim-lang, a templating language that similar to erb.
gem 'slim'

# Use unicorn as the app server
gem 'unicorn'

# Authentication & Accounts Gems
gem 'devise'
gem 'devise-async'
gem 'cancan'

# Enumerations
gem 'enumerate_it'

# Nokigiri to run xml requests from other servers
gem "nokogiri", "~> 1.6.1"

gem "curb", "~> 0.8.5"

gem 'h2ocube_rails_cache'

# _("Translations support!")
gem 'globalize'

gem 'gettext_i18n_rails'
gem 'gettext_i18n_rails_js', github: 'rdd-giga/gettext_i18n_rails_js'
gem 'gettext', require: false

# Add Sidekiq for Delayed Jobs
gem "sidekiq"
gem "sidetiq" #Used for scheduled jobs
gem 'sinatra', '>= 1.3.0', :require => false #sinatra is used for Sidekiq::Web

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  # SKIM for Slim JST
  gem 'skim'

  # Bootstrap-sass for putting Bootstrap into the application
  #gem 'bootstrap-sass'
  # Use github repo and 3 branch to use Bootstrap 3 (2.3.2 is on standard release gem)
  gem 'bootstrap-sass', '~> 3.1.1'

  gem 'uglifier', '>= 1.0.3'

  # Use Turbosprockets to speed up assets precompile by only compiling those that change.
  gem 'turbo-sprockets-rails3'

end

group :development do
  gem 'rspec-rails'

  # Byebug for debugging
  gem 'byebug'

  gem 'capistrano', '~> 2.15.0'
  gem 'rvm-capistrano'
  # Do not use new capistrano-unicorn until unicorn gem updates..
  # https://github.com/defunkt/unicorn/pull/7
  gem 'capistrano-unicorn', github: 'rdd-giga/capistrano-unicorn'

  # https://github.com/grosser/gettext_i18n_rails/issues/89
  gem 'ruby_parser', :require => false

end

group :test do
  # Shoulda matchers for simplifying the writing of tests
  gem 'shoulda-matchers', '>= 1.4.2'
  # Factory Girl for initializing test objects
  gem 'factory_girl_rails', '>= 1.4.0'
  # Randexp provides way to output random strings / expressions in tests
  gem 'randexp'
  # Temping gem allows creating fake tables to test relations like on concerns
  gem 'temping'

  gem 'database_cleaner', '>= 0.7.0'

  # Resque_spec for testing resque jobs
  gem 'resque_spec'

  gem 'spork'

  gem 'rr', require: false
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
