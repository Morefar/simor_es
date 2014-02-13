CarrierWave::Backgrounder.configure do |c|
  c.backend :sidekiq, queue: :carrierwave
  # c.backend :sucker_punch, queue: :carrierwave
end
