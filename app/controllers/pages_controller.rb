class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def landing
    render layout: 'static'
  end
end
