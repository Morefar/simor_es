class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_i18n_locale_from_params
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  protected
    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:alert] = "#{params[:locale]} traducción no disponible."
          logger.error flash.now[:alert]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :account_name]
      devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name]
    end
end
