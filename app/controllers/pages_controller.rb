class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def landing
    render layout: 'static'
  end
end
