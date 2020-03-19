class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @transactions = Kaminari.paginate_array(@user.transactions).page(params[:page]).per(6)
  end

  def set_user
    @user = UserDecorator.new(current_user)
  end
end
