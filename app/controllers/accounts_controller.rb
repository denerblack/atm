class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def show
  end

  def update
    @account.update(account_params)
    render :show
  end

  private

  def account_params
    params.require(:account).permit(:active)
  end

  def set_account
    @account = Account.find(params[:id])
  end
end
