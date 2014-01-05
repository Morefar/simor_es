class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_i18n_locale_from_params

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
end
