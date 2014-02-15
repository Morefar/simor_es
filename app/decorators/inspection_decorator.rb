class InspectionDecorator < Draper::Decorator
  delegate_all

  MODEL_METHODS = [:inspection_number, :asset_license_plate, :insured_value,
                   :inspection_order_id,  :address, :city, :currency,
                   :state, :current_value, :appraiser_value, :soat_number,
                   :soat_begin_date, :soat_finish_date, :emissions_certificate,
                   :emissions_begin_date, :emissions_finish_date,
                   :accesories, :insurance_number,
                   :insurance_company_name, :odometer, :asset_book_value,
                   :current_value, :appraiser_value, :insurance_start,
                   :insurance_finish]

  MODEL_METHODS.each do |method|
    define_method "#{ method.to_s }" do
      handle_none(self.model.send(method)) do
        if method.to_s.end_with? "_date"
          self.model.send(method).to_date.strftime("%d/%m/%Y")
        elsif method.to_s.end_with? "_value"
          h.local_number_to_currency(model.send(method))
        else
          self.model.send(method).to_s.upcase
        end
      end
    end
  end

  %w(created_at updated_at inspection_date).each do |datetime|
    define_method "#{datetime}" do
      model.send(datetime).localtime.strftime('%d-%m-%Y, %I:%M %p %Z')
    end
  end

  %w(interior_notes exterior_notes accesories observations).each do |observation|
    define_method "#{observation}" do
      handle_none model.send(observation) do
        model.send(observation)
      end
    end
  end

  %w(maintenance repairs security).each do |care|
    define_method "#{care}" do
      self.model.send(care) ? "Adecuado" : "Deficiente"
    end
  end

  def modifications
    self.model.modifications ? "Modificado" : "Sin modificaciones"
  end

  def document_slider
    if model.documents.empty?
      h.content_tag :section, id: "#{model_class_name}-slideshow" do
        h.image_tag("#{model_class_name}_placeholder.png")
      end
    else
      h.content_tag :section, id: "asset-slideshow", class: "slideshow-wrapper" do
        slider_options = "timer:false;animiation:slide;pause_on_hover:true;"\
          "variable_height:false;bullets:false"
        h.content_tag :ul, data: { orbit: "", options: slider_options } do
          slider_items = ""
          model.documents.each do |document|
            if document.content_type.starts_with? "image"
              slider_items << h.content_tag(:li,
                h.image_tag(document.content_url.to_s, class: 'th thmbnail'))
            end
          end
          slider_items.html_safe
        end
      end
    end
  end

  protected

  def handle_none(value)
    if value.present?
      yield
    else
      h.content_tag :span, "N/D", class: "none"
    end
  end
  def formatted_field(args = {})
      h.content_tag(:div, class: "medium-#{args[:column_size]} columns") do
        internationalized_attribute = I18n.t args[:attribute],
          scope: [:activerecord, :attributes, :asset]
        div_result = h.content_tag(:h5, internationalized_attribute,
                                   class: "field-title")
        div_result << "#{ args[:field_value] }"
        div_result.html_safe
      end.html_safe
  end
  def model_class_name
    model.class.to_s.downcase
  end

end
