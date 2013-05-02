class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :set_locale

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # # Get locale from top-level domain or return nil if such locale is not available
  # # You have to put something like:
  # #   127.0.0.1 application.com
  # #   127.0.0.1 application.it
  # #   127.0.0.1 application.pl
  # # in your /etc/hosts file to try this out locally
  # def extract_locale_from_tld
  #     parsed_locale = request.host.split(',').last
  #     I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  # end

  # # Get locale code from request subdomain (like http://it.application.local:3000)
  # # You have to put something like:
  # #   127.0.0.1 gr.application.local
  # # in your /etc/hosts file to try this out locally
  # def extract_locale_from_subdomain
  #     parsed_locale = request.subdomain.first
  #     I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  # end



end
