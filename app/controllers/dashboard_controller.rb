class DashboardController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @activities = PublicActivity::Activity.order(created_at: :desc).limit(20)
    @user = current_user
  end
end
