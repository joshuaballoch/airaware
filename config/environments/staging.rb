require 'uglifier'

Airaware::Application.configure do
  config.active_record.mass_assignment_sanitizer = :strict

  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Choose compressors to use
  config.assets.js_compressor = Uglifier.new(:copyright => false)

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Make sure to update asset modification times after precompile, so turbosprockets knows which assets it can clean up on clean_expired.
  config.assets.handle_expiration = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  ## TO DO: add qbox to serve assets
  # # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # # config.action_controller.asset_host = '//testen.gigabase.org'
  # config.action_controller.asset_host = Proc.new { |source|
  #   "//dn-giga-test-webapp-staging.qbox.me"
  # }

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Adding Webfonts to the Asset Pipeline
  config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  # config.i18n.fallbacks = {'en-US' => ['en-US', 'zh-CN'], 'zh-CN' => ['zh-CN', 'en-US'], 'fr' => ['fr', 'en-US']}

  # Send deprecation notices to registered listeners
  # config.active_support.  = :notify

  # config.action_mailer.default_url_options = { :host => 'test-webapp.gigabase.org' }
  # config.action_mailer.asset_host = 'test-webapp.gigabase.org'
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   :address              => "smtp.sendgrid.net",
  #   :port                 => 587,
  #   :domain               => 'gigabase.org',
  #   :user_name            => 'giga-test',
  #   :password             => 'V37eecHv2kQw',
  #   :authentication       => 'plain',
  #   :enable_starttls_auto => false  }

  # config.middleware.use ExceptionNotification::Rack, :email => {
  #   :email_prefix => "[Exception Giga Web-App Staging] ",
  #   :sender_address => %{"Exception Notifier" <support@gigabase.org>},
  #   :exception_recipients => %w{it@gigabase.org}
  #   }
end
