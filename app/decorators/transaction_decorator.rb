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
    when "withdraw"
      "#dc3545"
    when "deposit"
      "#007bff"
    end
  end

  def message
    kind.text
  end
end
