class TransactionsController < ApplicationController
  def withdraw
    transactions_service.make_withdraw(withdraw_params[:account_number], BigDecimal(withdraw_params[:value]))
  end

  def deposit
    result = transactions_service.make_deposit(deposit_params[:account_number], BigDecimal(deposit_params[:value]))

    if result.success?
      render json: result.marshal_dump.to_json, code: 200
    else
      render json: result.marshal_dump.to_json, code: 302
    end
  end

  def transfer
    account_from = transfer_params[:account_from]
    account_to   = transfer_params[:account_to]
    value        = transfer_params[:value]

    transactions_service.make_transfer(account_from, account_to, BigDecimal(value), Time.now)
  end

  private

  def withdraw_params
    params.permit(:account_number, :value)
  end

  def deposit_params
    params.permit(:account_number, :value)
  end

  def transfer_params
    params.permit(:account_from, :account_to, :value)
  end

  private

  def transactions_service
    @transactions_service ||= ::TransactionsService.new(Time.now)
  end
end
