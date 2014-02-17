module InspectionOrdersHelper
  def show_status(state)
    case state
    when "generated"
      "Generado"
    when "pending"
      "Pospuesto"
    when "scheduled"
      "Agendado"
    when "inspected"
      "Inspeccionado"
    end
  end

  def show_renew_period(period)
    return "Ninguno" if period.nil?
    "#{period} #{'mes'.pluralize(period, :es)}"
  end

  def next_inspection_date(order_date, renew_period)
    (order_date.localtime.to_date >> renew_period).strftime("%d/%m/%Y")
  end

  def show_priority(priority)
    return "Alta" if priority.eql?("high")
    "Normal"
  end
end
