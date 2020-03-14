class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
  end

  def set_user
    @user = UserDecorator.new(current_user)
  end
end
