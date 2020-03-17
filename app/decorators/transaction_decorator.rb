include ActionView::Helpers::NumberHelper

class TransactionDecorator < SimpleDelegator
  def formated_value
    number_to_currency(value, unit: "R$", separator: ",", delimiter: ".")
  end

  def date
    transactioned_at.strftime("%d/%m/%Y %H:%M:%S")
  end

  def action
    kind
  end

  def font_color
    case action
    when "withdraw", "rate"
      "#dc3545"
    when "deposit"
      "#007bff"
    end
  end

  def message
    if kind == :transfer
      #return "Transferência #{'from_to'} #{(account_to || account_from).user.fullname}"
      return "Transferência de #{account_from.user.fullname} para #{account_to.user.fullname}"
    end
    kind.text
  end
end
