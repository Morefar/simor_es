class EntityDecorator < Draper::Decorator
  delegate_all

  def email
    handle_none(model.email)
  end

  def phone
    handle_none model.phone do
      number = parse_phone_number(model.phone)
      h.number_to_phone number, area_code: true, raise: true
    end
  end

  def mobile_phone
    handle_none model.mobile_phone do
      number = parse_phone_number(model.mobile_phone)
      h.number_to_phone number, area_code: true, raise: true
    end
  end

  private
  def handle_none(value)
    if value.present?
      block_given? ? yield : value
    else
      h.content_tag :span, "N/D", class: "none"
    end
  end
  def parse_phone_number(number)
    number.delete "-_. a-zA-Z"
  end
end
