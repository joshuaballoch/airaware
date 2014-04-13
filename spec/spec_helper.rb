require 'spork'
require 'rails'
require 'database_cleaner'
require 'byebug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'

  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  if ENV['COVERAGE'] == 'on'
    require 'simplecov'
    require 'simplecov-rcov'
    class SimpleCov::Formatter::MergedFormatter
      def format(result)
        SimpleCov::Formatter::HTMLFormatter.new.format(result)
        SimpleCov::Formatter::RcovFormatter.new.format(result)
      end
    end
    SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
    SimpleCov.start 'rails' do
      add_filter "/vendor/"
      add_filter "/app/admin/"
      add_group "Decorators", "app/decorators"
      add_group "Observers", "app/observers"
      add_group "Jobs", "app/jobs"
      add_group "Libraries", "/lib/"
    end
  end

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'shoulda/matchers/integrations/rspec'
#  require 'draper/test/rspec_integration'
#  require 'paperclip/matchers'

  # Needed to generate urls with locales
  # require 'url_options_for_locale'
  # class ActionView::TestCase::TestController
  #   include UrlOptionsForLocale
  # end

  Rails.logger.level = 4
  Devise.stretches = 1

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    # config.include Paperclip::Shoulda::Matchers
    config.include Devise::TestHelpers, type: :controller

    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    # config.use_transactional_fixtures = true

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.before :suite do
      DeferredGarbageCollection.start

      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with :truncation

      require "#{Rails.root}/db/seeds"
    end
    config.before :each do
      I18n.locale = :"en-US"

      DatabaseCleaner.start
    end
    config.after :each do
      DatabaseCleaner.clean

      DeferredGarbageCollection.reconsider
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Disable Immortal until it gets added to GIGA
  # # Prevents immortal from being included twice which causes stack overflow
  # Immortal.module_eval do
  #   def self.included(base)
  #   end
  # end

  # Workaround due to active admin loading the models when it's mounted in the routes
  # So since models are loaded before the spork forks, they are not relaoded later on
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end

  # This seems creazy, but works fine!
  Dir["#{Rails.root}/app/observers/**/*.rb"].each do |observer|
    load observer
  end
end
