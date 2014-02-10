module ApplicationHelper
  def local_number_to_currency(number_attribute)
    loc(number_attribute).to_currency.to_s(precision: 2) unless number_attribute.nil?
  end
  def loc(attribute)
    attribute.localize("#{ I18n.locale }_co")
  end
  def sidebar_button(options = {})
    content_tag(:li, class: "btn-tny inactive") do
      link_to options[:url] do
        %{ #{ options[:label] }
        <i class="icon-#{options[:icon]} task-icon icon-large"></i> }.html_safe
      end
    end
  end
end
