class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @transactions = @user.transactions
    if filter_params = request.params[:filter]
      initial_date, final_date = filter_params[:initial_date], filter_params[:final_date]
      if initial_date && final_date
        @transactions = @transactions.select { |transaction| transaction.created_at >= "#{initial_date} 00:00:00" && transaction.created_at <= "#{final_date} 23:59:59" }
      end
    end
    @transactions = Kaminari.paginate_array(@transactions).page(params[:page]).per(6)
  end

  def set_user
    @user = UserDecorator.new(current_user)
  end

end
