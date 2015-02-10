class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def landing
    fresh_when(last_modified: 1.month.ago, public: true)
    render layout: 'static'
  end
end
