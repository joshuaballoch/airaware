#source 'https://rubygems.org'
source 'http://ruby.taobao.org/'

gem 'rails', '3.2.17'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Slim for slim-lang, a templating language that similar to erb.
gem 'slim'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'rails-assets-bootstrap'

  gem 'uglifier', '>= 1.0.3'
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
