module ApplicationHelper
  def local_number_to_currency(number_attribute)
    loc(number_attribute).to_currency.to_s(precision: 2)
  end
  def loc(attribute)
    attribute.localize(I18n.locale)
  end
end
