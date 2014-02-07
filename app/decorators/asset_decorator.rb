class AssetDecorator < Draper::Decorator
  delegate_all

  ASSET_METHODS = [:license_plate, :make_name, :model_name, :cylinder_cap,
                   :color_name, :service_type, :kind_name, :body_name,
                   :fuel_type, :capacity, :motor_number, :vin, :serial_number,
                   :chassis_number, :mobility_restriction, :shield_level,
                   :horse_power, :number_of_doors, :property_limitation,
                   :transit_authority, :import_date, :tp_expiration_date,
                   :tp_issue_date, :tp_expiration_date, :registration_date]

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
                         "variable_height:true;bullets:false"
        h.content_tag :ul, data: { orbit: "", options: slider_options } do
          h.content_tag_for(:li, model.documents) do |document|
            h.image_tag(document.content_url(:thumb).to_s, class: 'thmbnail')
          end
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
    html_result = ""
    if model.importd_assembld?
      html_result << h.content_tag(:b, "Importado", class: "medium-4 columns")
      html_result << h.content_tag(:b,
                    "#{h.t('activerecord.attributes.asset.import_statement')}:",
                    class: "medium-2 columns")
      html_result << h.content_tag(:span,
                    model.import_statement, class: "medium-2 columns")
      html_result << h.content_tag(:b,
                    "#{h.t('activerecord.attributes.asset.import_date')}:",
                    class: "medium-2 columns")
      html_result << h.content_tag(:span,
                    model.import_date.to_date.strftime("%d/%m/%Y"),
                    class: "medium-2 columns")
    else
      html_result << h.content_tag(:b, "Ensamblado", class: "medium-4 columns")
    end
    html_result.html_safe
  end

  private
  def handle_none(value)
    if value.present?
      yield
    else
      h.content_tag :span, "N/D", class: "none"
    end
  end
end
