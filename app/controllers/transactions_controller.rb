class TransactionsController < ApplicationController
  def withdraw
    result = transactions_service.make_withdraw(withdraw_params[:account_number], BigDecimal(withdraw_params[:value]))

    render json: result.marshal_dump.to_json, status: 200
  end

  def deposit
    result = transactions_service.make_deposit(deposit_params[:account_number], BigDecimal(deposit_params[:value]))

    render json: result.marshal_dump.to_json, status: 200
  end

  def transfer
    account_from = transfer_params[:account_from]
    account_to   = transfer_params[:account_to]
    value        = transfer_params[:value]

    result = transactions_service.make_transfer(account_from, account_to, BigDecimal(value))

    render json: result.marshal_dump.to_json, status: 200
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
