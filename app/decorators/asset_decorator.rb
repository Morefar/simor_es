class AssetDecorator < Draper::Decorator
  delegate_all

  ASSET_METHODS = [:license_plate, :make_name, :model_name, :cylinder_cap,
                   :color_name, :service_type, :kind_name, :body_name,
                   :fuel_type, :capacity, :motor_number, :vin, :serial_number,
                   :chassis_number, :mobility_restriction, :shield_level,
                   :horse_power, :number_of_doors, :property_limitation,
                   :transit_authority, :import_date, :tp_expiration_date,
                   :tp_issue_date, :tp_expiration_date, :registration_date,
                   :transit_permit, :import_statement]

  ASSET_METHODS.each do |method|
    define_method "#{ method.to_s }" do
      handle_none model.send(method) do
        if method.to_s.end_with? "_date"
          model.send(method).to_date.strftime("%d/%m/%Y")
        else
          model.send(method).to_s.upcase
        end
      end
    end
  end

  def document_slider
    if model.documents.empty?
      h.content_tag :section, id: "asset-slideshow" do
        h.image_tag("car_placeholder.png")
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

  %w(motor serial chassis).each do |action|
    define_method("rerecorded_#{action}") do
      model.send("rerecorded_#{action}?") ? h.t('shared.yes') : h.t('shared.no')
    end
  end

  def imported?
    formatted_field field_value: model.importd_assembld? ? "Importado" : "Ensamblado",
                    column_size: 4,
                    attribute: "importd_assembld"
  end

  private
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
end
