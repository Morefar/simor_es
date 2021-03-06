module ApplicationHelper
  def local_number_to_currency(number_attribute)
    loc(number_attribute).to_currency.to_s(precision: 2) unless number_attribute.nil?
  end
  def loc(attribute)
    attribute.localize("#{ I18n.locale }_co")
  end
  def sidebar_button(options = {})
    method = options[:method] || :get
    style = options[:class] || "btn-tny"
    content_tag :li do
      link_to options[:url], method: method, class: style do
        %{ <span class="cue">&#10095;</span>
        <i class="icon-#{options[:icon]} task-icon icon-large"></i>
        <span class="btn-label">#{ options[:label] }</span> }.html_safe
      end
    end
  end
  def link_to_add_fields(name, form, association)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.
      fields_for(association, new_object, child_index: id) do |builder|
        render "#{ association.to_s.singularize }_fields", f: builder
    end
    link_to name, "#", class: "add_fields",
      data: { id: id, fields: fields.gsub("\n", "") }
  end
end
