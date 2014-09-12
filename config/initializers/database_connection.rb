module Platform
  module Database
    def connect(size=5)
      if Rails.application.config.database_configuration
        config = ActiveRecord::Base.configurations[Rails.env] ||
          Rails.application.config.database_configuration[Rails.env]
        config['reaping_frequency'] = ENV["DB_REAP_FREQ"] || 10 # seconds
        config['pool']              = ENV["DB_POOL"] || ENV["MAX_THREADS"] || size
        ActiveRecord::Base.establish_connection(config)
      end
    end

    def disconnect
      ActiveRecord::Base.connection_pool.disconnect!
    end

    def reconnect(size)
      disconnect
      connect(size)
    end
    module_function :disconnect, :connect, :reconnect
  end
end



Rails.application.config.after_initialize do
  Platform::Database.disconnect

  ActiveSupport.on_load(:active_record) do
    if Puma.respond_to?(:cli_config)
      size = Puma.cli_config.options.fetch(:max_threads)
      Platform::Database.reconnect(size)
    else
      Platform::Database.connect
    end

    Sidekiq.configure_server do |config|
      size = Sidekiq.options[:concurrency]
      Platform::Database.reconnect(size)
    end
  end
end
