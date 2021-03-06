Simor::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eagedigests for assets URLs.
  config.assets.digest = true

  # Asset Cache-Control
  config.static_cache_control = "public, max-age=31536000"

  # Asset compression
  config.assets.css_compressor = :sass
  config.assets.js_compressor = :uglifier

  config.assets.precompile += %w( vendor/modernizr.js )
  # Eager load code on boot.
  config.eager_load = true

  # Version of your assets, change this if you want to expire all your assets.
  # config.assets.version = '1.0' has moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.action_controller.asset_host = ENV["AWS_ASSETS_CDN"]

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Action mailer configuration
  config.action_mailer.default_url_options = { host: ENV['PRODUCTION_HOST'] }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default = { charset: "utf-8" }
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: ENV['GMAIL_DOMAIN'],
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV['GMAIL_USERNAME'],
    password: ENV['GMAIL_PASSWORD']
  }
end
